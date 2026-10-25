"""Evalúa solucion.generar_sql sobre la validación propia, imitando al evaluador del docente.

Por cada pregunta de datos/validacion/<nombre>/preguntas.json:
  - esquema = SHOW CREATE TABLE de cada tabla de la base `val_<nombre>`;
  - ejecutar(sql) con el usuario de solo lectura `lector`: {ok, columnas, filas (máx. 10), error},
    máximo 3 llamadas por pregunta (--sin-ejecutar para no entregarlo);
  - acierto por ejecución: números redondeados a 2 decimales, filas como multiconjunto
    (en orden solo si `ordenado`), una columna adicional no penaliza;
  - más de 30 s o una salida que no sea SELECT/WITH cuentan como error.
EX ponderada: fácil 1, media 2, difícil 3.

Los resultados se guardan en resultados/validacion_propia.csv; si ya hay filas de la misma
etiqueta, se reemplazan (así el CSV acumula baseline, A, B, etc.).

Uso (los esquemas deben estar cargados: cargar_validacion.py):
  T2S_CONFIG=configs/baseline.json python scripts/evaluacion/evaluar.py
  T2S_CONFIG=configs/lora_B.json python scripts/evaluacion/evaluar.py --sin-ejecutar
  python scripts/evaluacion/evaluar.py --oraculo     # prueba el evaluador sin modelo (EX = 1)
"""
import argparse
import csv
import itertools
import json
import os
import sys
import time
from collections import Counter
from datetime import date, datetime, timedelta
from decimal import Decimal
from pathlib import Path

import pymysql

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from comun import MYSQL, ejecutar, es_solo_lectura, esquema_de_base  # noqa: E402

RAIZ = Path(__file__).resolve().parents[2]
CARPETA = RAIZ / "datos/validacion"
SALIDA = RAIZ / "resultados/validacion_propia.csv"
PREFIJO_DB = "val_"
PESOS = {"facil": 1, "media": 2, "dificil": 3}
TIEMPO_MAX = 30.0
MAX_LLAMADAS = 3
MAX_FILAS_EJECUTAR = 10
MAX_ASIGNACIONES = 20000   # límite de combinaciones al emparejar columnas
COLUMNAS_CSV = ["config", "id", "nivel", "peso", "pregunta", "sql_referencia", "sql_generada",
                "acierto", "categoria_error", "tiempo_s"]


def conectar_lector(db):
    return pymysql.connect(database=db, **{**MYSQL, "user": "lector", "password": "lector"})


def normalizar(v):
    if isinstance(v, bool):
        return float(v)
    if isinstance(v, (int, float, Decimal)):
        return round(float(v), 2) + 0.0   # + 0.0 convierte -0.0 en 0.0
    if isinstance(v, (date, datetime, timedelta)):
        return str(v)
    if isinstance(v, bytes):
        return v.decode("utf-8", errors="replace")
    return v


def mismo_resultado(ref, gen, ordenado):
    """True si `gen` contiene las columnas de `ref` (en cualquier posición) con las mismas filas."""
    filas_ref = [tuple(normalizar(v) for v in f) for f in ref]
    filas_gen = [tuple(normalizar(v) for v in f) for f in gen]
    if len(filas_ref) != len(filas_gen):
        return False
    if not filas_ref:
        return True
    k, m = len(filas_ref[0]), len(filas_gen[0])
    if m < k:
        return False
    # candidatas: columnas generadas con el mismo multiconjunto de valores que cada columna de referencia
    col_ref = [Counter(f[i] for f in filas_ref) for i in range(k)]
    col_gen = [Counter(f[j] for f in filas_gen) for j in range(m)]
    candidatas = [[j for j in range(m) if col_gen[j] == col_ref[i]] for i in range(k)]
    if any(not c for c in candidatas):
        return False
    esperado = filas_ref if ordenado else Counter(filas_ref)
    for intento, asignacion in enumerate(itertools.product(*candidatas)):
        if intento >= MAX_ASIGNACIONES:
            break
        if len(set(asignacion)) < k:
            continue
        proyectadas = [tuple(f[j] for j in asignacion) for f in filas_gen]
        if (proyectadas if ordenado else Counter(proyectadas)) == esperado:
            return True
    return False


def evaluar_pregunta(generar_sql, conn, esquema, p, con_ejecutar):
    llamadas = 0

    def ejecutar_modelo(sql):
        nonlocal llamadas
        llamadas += 1
        if llamadas > MAX_LLAMADAS:
            return dict(ok=False, columnas=[], filas=[], error="límite de llamadas a ejecutar")
        r = ejecutar(conn, sql, max_filas=MAX_FILAS_EJECUTAR)
        return {k: r[k] for k in ("ok", "columnas", "filas", "error")}

    inicio = time.monotonic()
    try:
        sql = generar_sql(esquema, p["pregunta"], ejecutar_modelo if con_ejecutar else None)
    except Exception as e:   # el evaluador del docente lo contaría como error
        sql = f"-- excepción: {e}"
    tiempo = time.monotonic() - inicio
    sql = (sql or "").strip()

    if tiempo > TIEMPO_MAX:
        return sql, False, "tiempo_excedido", tiempo
    if not es_solo_lectura(sql):
        return sql, False, "no_select", tiempo
    ref = ejecutar(conn, p["sql_referencia"])
    if not ref["ok"]:
        raise RuntimeError(f"{p['id']}: la consulta de referencia falla: {ref['error']}")
    gen = ejecutar(conn, sql)
    if not gen["ok"]:
        return sql, False, gen["categoria"], tiempo
    if mismo_resultado(ref["filas"], gen["filas"], p.get("ordenado", False)):
        return sql, True, "", tiempo
    return sql, False, "resultado_distinto", tiempo


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--sin-ejecutar", action="store_true",
                    help="no entregar ejecutar() al modelo (sin autocorrección)")
    ap.add_argument("--oraculo", action="store_true",
                    help="responder con la consulta de referencia, sin modelo (prueba del evaluador)")
    ap.add_argument("--etiqueta", help="nombre de la configuración en el CSV "
                    "(por defecto, el nombre del archivo de T2S_CONFIG)")
    args = ap.parse_args()

    ruta_config = os.environ.get("T2S_CONFIG", "config.json")
    etiqueta = args.etiqueta or ("oraculo" if args.oraculo else Path(ruta_config).stem)
    if args.sin_ejecutar and not args.etiqueta:
        etiqueta += "_sin_ejecutar"

    preguntas_por_db = {}
    for d in sorted(d for d in CARPETA.iterdir() if (d / "preguntas.json").exists()):
        preguntas_por_db[d.name] = json.loads((d / "preguntas.json").read_text(encoding="utf-8"))

    if args.oraculo:
        referencias = {p["pregunta"]: p["sql_referencia"]
                       for ps in preguntas_por_db.values() for p in ps}

        def generar_sql(esquema, pregunta, ejecutar_modelo=None):
            return referencias[pregunta]
    else:
        sys.path.insert(0, str(RAIZ))
        print(f"Cargando modelo ({ruta_config})...")
        from solucion import generar_sql

    filas, base_de = [], {}
    for nombre, preguntas in preguntas_por_db.items():
        base_de.update({p["id"]: nombre for p in preguntas})
        conn = conectar_lector(PREFIJO_DB + nombre)
        esquema = esquema_de_base(conn, PREFIJO_DB + nombre)
        for p in preguntas:
            sql, acierto, categoria, tiempo = evaluar_pregunta(
                generar_sql, conn, esquema, p, not args.sin_ejecutar)
            print(f"{p['id']:8} {p['nivel']:8} {'OK ' if acierto else 'MAL'} {tiempo:5.1f}s "
                  f"{categoria}")
            filas.append(dict(config=etiqueta, id=p["id"], nivel=p["nivel"],
                              peso=PESOS[p["nivel"]], pregunta=p["pregunta"],
                              sql_referencia=p["sql_referencia"], sql_generada=sql,
                              acierto=int(acierto), categoria_error=categoria,
                              tiempo_s=round(tiempo, 2)))
        conn.close()

    def ex(fs):
        total = sum(f["peso"] for f in fs)
        return sum(f["peso"] for f in fs if f["acierto"]) / total if total else 0.0

    print(f"\n=== {etiqueta} ===")
    for nivel in PESOS:
        fs = [f for f in filas if f["nivel"] == nivel]
        print(f"{nivel:8} {sum(f['acierto'] for f in fs)}/{len(fs)}")
    for nombre in preguntas_por_db:
        fs = [f for f in filas if base_de[f["id"]] == nombre]
        print(f"{nombre:18} EX {ex(fs):.3f}")
    print(f"EX ponderada: {ex(filas):.3f}   tiempo máx.: {max(f['tiempo_s'] for f in filas):.1f}s")
    errores = Counter(f["categoria_error"] for f in filas if not f["acierto"])
    if errores:
        print("errores:", dict(errores.most_common()))

    anteriores = []
    if SALIDA.exists():
        with open(SALIDA, encoding="utf-8", newline="") as f:
            anteriores = [r for r in csv.DictReader(f) if r["config"] != etiqueta]
    SALIDA.parent.mkdir(parents=True, exist_ok=True)
    with open(SALIDA, "w", encoding="utf-8", newline="") as f:
        w = csv.DictWriter(f, fieldnames=COLUMNAS_CSV)
        w.writeheader()
        w.writerows(anteriores + filas)
    print(f"Guardado en {SALIDA.relative_to(RAIZ)}")


if __name__ == "__main__":
    main()
