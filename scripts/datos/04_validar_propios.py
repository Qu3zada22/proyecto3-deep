"""Carga los esquemas propios en MySQL 8.4.10 y valida sus pares pregunta–SQL.

Cada esquema vive en datos/esquemas_propios/<nombre>/ con:
  esquema.sql   CREATE TABLE con COMMENT en tablas y columnas
  datos.sql     INSERT con datos de ejemplo
  pares.json    [{"pregunta": ..., "sql": ..., "nivel": "facil|media|dificil"}, ...]

Un par se acepta si: es SELECT/WITH de solo lectura, corre sin error y no es
duplicado. Se marca (pero se conserva) si devuelve 0 filas.

Salidas (sin --esquema):
  datos/procesados/propios.jsonl
  datos/procesados/esquemas_propios/<nombre>.sql   (SHOW CREATE TABLE)
  datos/descartes/propios_descartes.csv
Uso:
  .venv/bin/python scripts/datos/04_validar_propios.py              # todos
  .venv/bin/python scripts/datos/04_validar_propios.py --esquema tienda   # solo revisar uno
"""
import argparse
import csv
import json
import sys
from collections import Counter
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from comun import conectar, ejecutar, es_solo_lectura, esquema_de_base  # noqa: E402

RAIZ = Path(__file__).resolve().parents[2]
CARPETA = RAIZ / "datos/esquemas_propios"
PREFIJO_DB = "pr_"


def ejecutar_script(conn, texto):
    """Ejecuta un archivo .sql sentencia por sentencia (separadas por ';' a fin de línea)."""
    sentencias, actual = [], []
    for linea in texto.splitlines():
        if linea.strip().startswith("--"):
            continue
        actual.append(linea)
        if linea.rstrip().endswith(";"):
            sentencias.append("\n".join(actual))
            actual = []
    if "".join(actual).strip():
        sentencias.append("\n".join(actual))
    with conn.cursor() as cur:
        for s in sentencias:
            if s.strip():
                cur.execute(s)


def cargar(conn, nombre):
    db = PREFIJO_DB + nombre
    with conn.cursor() as cur:
        cur.execute(f"DROP DATABASE IF EXISTS `{db}`")
        cur.execute(f"CREATE DATABASE `{db}`")
    conn.select_db(db)
    ejecutar_script(conn, (CARPETA / nombre / "esquema.sql").read_text(encoding="utf-8"))
    ejecutar_script(conn, (CARPETA / nombre / "datos.sql").read_text(encoding="utf-8"))
    return db


def validar(conn, nombre, db):
    pares = json.loads((CARPETA / nombre / "pares.json").read_text(encoding="utf-8"))
    conn.select_db(db)
    validos, descartes, vistos = [], [], set()
    for i, p in enumerate(pares):
        base = dict(id=f"propio_{nombre}_{i}", fuente="propio", db_id=nombre,
                    pregunta=p["pregunta"].strip(), sql=p["sql"].strip().rstrip(";"),
                    nivel=p.get("nivel", ""))
        clave = base["pregunta"].lower()
        if clave in vistos:
            descartes.append({**base, "motivo": "duplicado", "error": ""})
            continue
        vistos.add(clave)
        if not es_solo_lectura(base["sql"]):
            descartes.append({**base, "motivo": "no_es_select", "error": ""})
            continue
        r = ejecutar(conn, base["sql"], max_filas=1000)
        if not r["ok"]:
            descartes.append({**base, "motivo": r["categoria"], "error": r["error"]})
            continue
        validos.append({**base, "filas_vacias": len(r["filas"]) == 0, "n_filas": len(r["filas"])})
    return validos, descartes


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--esquema", help="validar solo este esquema (no escribe salidas)")
    args = ap.parse_args()
    nombres = [args.esquema] if args.esquema else sorted(
        d.name for d in CARPETA.iterdir() if (d / "pares.json").exists())

    conn = conectar()
    todos_v, todos_d = [], []
    for nombre in nombres:
        db = cargar(conn, nombre)
        v, d = validar(conn, nombre, db)
        niveles = Counter(x["nivel"] for x in v)
        vacias = sum(x["filas_vacias"] for x in v)
        print(f"{nombre}: {len(v)} válidos {dict(niveles)}, {len(d)} descartados, "
              f"{vacias} con 0 filas")
        for x in d:
            print(f"   DESCARTE [{x['motivo']}] {x['pregunta'][:70]} -> {x['error'][:150]}")
        if args.esquema:
            for x in v:
                if x["filas_vacias"]:
                    print(f"   0 FILAS: {x['pregunta'][:90]}")
        todos_v += v
        todos_d += d

    if args.esquema:
        return
    proc = RAIZ / "datos/procesados"
    (proc / "esquemas_propios").mkdir(parents=True, exist_ok=True)
    for nombre in nombres:
        (proc / "esquemas_propios" / f"{nombre}.sql").write_text(
            esquema_de_base(conn, PREFIJO_DB + nombre) + "\n", encoding="utf-8")
    with open(proc / "propios.jsonl", "w", encoding="utf-8") as f:
        for v in todos_v:
            f.write(json.dumps(v, ensure_ascii=False) + "\n")
    with open(RAIZ / "datos/descartes/propios_descartes.csv", "w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=["id", "fuente", "db_id", "pregunta", "sql", "nivel",
                                          "motivo", "error"])
        w.writeheader()
        w.writerows(todos_d)
    print(f"TOTAL: {len(todos_v)} válidos, {len(todos_d)} descartados")


if __name__ == "__main__":
    main()
