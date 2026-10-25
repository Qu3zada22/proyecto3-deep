"""Convierte Spider (SQLite) a MySQL 8.4.10.

Paso 1 (cargar): crea cada base de Spider en MySQL con tipos MySQL, PK y FK,
  identificadores en minúscula, y copia hasta MAX_FILAS filas por tabla.
Paso 2 (convertir): traduce cada consulta de SQLite a MySQL con sqlglot,
  la ejecuta en MySQL y conserva solo las que corren sin error.

Salidas:
  datos/procesados/spider_mysql.jsonl      pares válidos (pregunta en inglés)
  datos/procesados/esquemas_spider/*.sql   SHOW CREATE TABLE de cada base
  datos/descartes/spider_descartes.csv     pares descartados y motivo

Uso:  .venv/bin/python scripts/datos/02_spider_a_mysql.py [--solo-convertir]
"""
import argparse
import csv
import json
import re
import sqlite3
import sys
from collections import Counter
from pathlib import Path

import sqlglot
from sqlglot import exp
from tqdm import tqdm

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from comun import conectar, ejecutar, esquema_de_base  # noqa: E402

RAIZ = Path(__file__).resolve().parents[2]
SPIDER = RAIZ / "datos/crudo/spider_data"
PROC = RAIZ / "datos/procesados"
DESC = RAIZ / "datos/descartes"
SPLITS = ["train_spider.json", "train_others.json", "dev.json"]
MAX_FILAS = 30000
RE_FECHA = re.compile(r"^\d{4}-\d{2}-\d{2}$")
RE_FECHAHORA = re.compile(r"^\d{4}-\d{2}-\d{2}[ T]\d{2}:\d{2}(:\d{2}(\.\d+)?)?$")


def q(nombre):
    return "`" + nombre.replace("`", "``") + "`"


# ---------------------------------------------------------------- paso 1
def tipo_mysql(declarado, valores):
    """Elige un tipo MySQL a partir del tipo SQLite declarado y los datos."""
    d = (declarado or "").upper().strip()
    base = d.split("(")[0].strip()
    no_nulos = [v for v in valores if v is not None and v != ""]
    if any(k in base for k in ("INT", "BOOL", "BIT")) or base == "NUMBER" and "," not in d:
        enteros = [v for v in no_nulos if isinstance(v, int)]
        grande = any(abs(v) > 2_000_000_000 for v in enteros)
        return "bigint" if grande else "int"
    if base == "YEAR":
        return "int"
    if base in ("REAL", "FLOAT", "DOUBLE"):
        return "double"
    if base in ("DECIMAL", "NUMERIC", "NUMBER"):
        m = re.search(r"\((\d+)\s*,\s*(\d+)\)", d)
        if m and int(m.group(1)) <= 65:
            return f"decimal({m.group(1)},{m.group(2)})"
        return "double"
    if base in ("DATE", "DATETIME", "TIMESTAMP"):
        txt = [str(v) for v in no_nulos]
        if txt and all(RE_FECHA.match(v) for v in txt):
            return "date"
        if txt and all(RE_FECHA.match(v) or RE_FECHAHORA.match(v) for v in txt):
            return "datetime"
        # fechas con formatos mixtos: se guardan como texto (así vienen en Spider)
    if base == "BLOB":
        return "blob"
    largo = max((len(str(v)) for v in no_nulos), default=0)
    if largo > 1000:
        return "text"
    m = re.search(r"\((\d+)\)", d)
    n = max(int(m.group(1)) if m else 0, largo, 1)
    return f"varchar({min(max(n, 50) if not m else n, 1000)})"


def cargar_base(conn, db_id):
    ruta = SPIDER / "database" / db_id / f"{db_id}.sqlite"
    lite = sqlite3.connect(ruta)
    lite.text_factory = lambda b: b.decode("utf-8", errors="replace")
    tablas = [r[0] for r in lite.execute(
        "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'")]

    info, datos, tipos = {}, {}, {}
    for t in tablas:
        info[t] = lite.execute(f'PRAGMA table_info("{t}")').fetchall()
        datos[t] = lite.execute(f'SELECT * FROM "{t}" LIMIT {MAX_FILAS}').fetchall()
        for i, (_, col, decl, *_r) in enumerate(info[t]):
            tipos[(t.lower(), col.lower())] = tipo_mysql(decl, [f[i] for f in datos[t]])

    # FK: la columna que referencia toma el tipo de la referenciada (si no, MySQL rechaza la FK)
    fks = {}
    for t in tablas:
        lista = []
        for r in lite.execute(f'PRAGMA foreign_key_list("{t}")').fetchall():
            ref_t, col, ref_c = r[2].lower(), r[3].lower(), (r[4] or "").lower()
            if (ref_t, ref_c) in tipos and (t.lower(), col) in tipos:
                tipos[(t.lower(), col)] = tipos[(ref_t, ref_c)]
                lista.append((col, ref_t, ref_c))
        fks[t] = lista
    with conn.cursor() as cur:
        cur.execute(f"DROP DATABASE IF EXISTS {q(db_id)}")
        cur.execute(f"CREATE DATABASE {q(db_id)}")
        cur.execute(f"USE {q(db_id)}")
        cur.execute("SET SESSION sql_mode=''")          # solo para cargar datos sucios
        cur.execute("SET SESSION foreign_key_checks=0")

        def crear(t, con_fk):
            cols = [f"  {q(c.lower())} {tipos[(t.lower(), c.lower())]}" for _, c, *_r in info[t]]
            pk = [c.lower() for _, c, _, _, _, p in sorted(info[t], key=lambda r: r[5]) if p]
            if pk and all(tipos[(t.lower(), c)] not in ("text", "blob") for c in pk):
                cols.append(f"  PRIMARY KEY ({', '.join(q(c) for c in pk)})")
            if con_fk:
                for col, rt, rc in fks[t]:
                    cols.append(f"  FOREIGN KEY ({q(col)}) REFERENCES {q(rt)} ({q(rc)})")
            cur.execute(f"CREATE TABLE {q(t.lower())} (\n" + ",\n".join(cols) + "\n)")

        # primero sin FK (para que exista todo), luego se agregan las FK que MySQL acepte
        for t in tablas:
            crear(t, con_fk=False)
        fk_fallidas = 0
        for t in tablas:
            for col, rt, rc in fks[t]:
                try:
                    cur.execute(f"ALTER TABLE {q(t.lower())} ADD FOREIGN KEY ({q(col)}) "
                                f"REFERENCES {q(rt)} ({q(rc)})")
                except Exception:
                    fk_fallidas += 1
        for t in tablas:
            if not datos[t]:
                continue
            n = len(info[t])
            sql = f"INSERT IGNORE INTO {q(t.lower())} VALUES ({', '.join(['%s'] * n)})"
            for i in range(0, len(datos[t]), 2000):
                cur.executemany(sql, datos[t][i:i + 2000])
    lite.close()
    return fk_fallidas


# ---------------------------------------------------------------- paso 2
RE_COMILLAS_DOBLES = re.compile(r'"([^"]*)"')


def sqlite_a_mysql(sql):
    """Spider usa "texto" como literal: se pasa a 'texto' y luego sqlglot traduce."""
    sql = RE_COMILLAS_DOBLES.sub(lambda m: "'" + m.group(1).replace("'", "''") + "'", sql)
    arbol = sqlglot.parse_one(sql, read="sqlite")

    def minusculas(nodo):
        if isinstance(nodo, exp.Identifier):
            nodo.set("this", nodo.this.lower())
        return nodo

    arbol = arbol.transform(minusculas)
    return arbol.sql(dialect="mysql")


def convertir():
    pares = []
    for split in SPLITS:
        for i, ej in enumerate(json.loads((SPIDER / split).read_text())):
            pares.append(dict(id=f"{split.split('.')[0]}_{i}", fuente=f"spider/{split}", **{
                k: ej[k] for k in ("db_id", "question", "query")}))

    validos, descartes, motivos = [], [], Counter()
    conn = conectar()
    vistos = set()
    for p in tqdm(pares, desc="convertir"):
        clave = (p["db_id"], p["question"].strip().lower())
        if clave in vistos:
            motivos["duplicado"] += 1
            descartes.append({**p, "sql_mysql": "", "motivo": "duplicado", "error": ""})
            continue
        vistos.add(clave)
        try:
            sql = sqlite_a_mysql(p["query"])
        except Exception as e:  # sqlglot no pudo parsear
            motivos["no_traducible"] += 1
            descartes.append({**p, "sql_mysql": "", "motivo": "no_traducible", "error": str(e)[:200]})
            continue
        conn.select_db(p["db_id"])
        r = ejecutar(conn, sql, max_filas=50)
        if not r["ok"]:
            motivos[r["categoria"]] += 1
            descartes.append({**p, "sql_mysql": sql, "motivo": r["categoria"], "error": r["error"][:200]})
            continue
        validos.append({**p, "sql_mysql": sql, "filas_vacias": len(r["filas"]) == 0})

    PROC.mkdir(parents=True, exist_ok=True)
    DESC.mkdir(parents=True, exist_ok=True)
    with open(PROC / "spider_mysql.jsonl", "w") as f:
        for v in validos:
            f.write(json.dumps(v, ensure_ascii=False) + "\n")
    with open(DESC / "spider_descartes.csv", "w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=["id", "fuente", "db_id", "question", "query",
                                          "sql_mysql", "motivo", "error"])
        w.writeheader()
        w.writerows(descartes)
    resumen = dict(total=len(pares), validos=len(validos), descartados=len(descartes),
                   motivos=dict(motivos.most_common()))
    (DESC / "spider_resumen.json").write_text(json.dumps(resumen, indent=2, ensure_ascii=False))
    print(json.dumps(resumen, indent=2, ensure_ascii=False))


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--solo-convertir", action="store_true")
    args = ap.parse_args()

    dbs = sorted({ej["db_id"] for s in SPLITS for ej in json.loads((SPIDER / s).read_text())})
    conn = conectar()
    if not args.solo_convertir:
        fk_fallidas = 0
        for db in tqdm(dbs, desc="cargar"):
            fk_fallidas += cargar_base(conn, db)
        print(f"{len(dbs)} bases cargadas; FK que MySQL rechazó: {fk_fallidas}")
    salida = PROC / "esquemas_spider"
    salida.mkdir(parents=True, exist_ok=True)
    for db in dbs:
        (salida / f"{db}.sql").write_text(esquema_de_base(conn, db) + "\n")
    convertir()


if __name__ == "__main__":
    main()
