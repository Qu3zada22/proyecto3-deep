"""Verifica que los esquemas de validación NO aparezcan en el entrenamiento (penalización −15).

Compara cada esquema de datos/validacion/<nombre>/esquema.sql contra todos los
esquemas usados en datos/entrenamiento/train.jsonl y dev_interno.jsonl:
  - nombre de base repetido
  - solapamiento de nombres de tabla (Jaccard >= 0.4)
  - preguntas idénticas
Termina con código 1 si encuentra algo.

Uso: .venv/bin/python scripts/evaluacion/verificar_fuga.py
"""
import json
import re
import sys
from pathlib import Path

RAIZ = Path(__file__).resolve().parents[2]
RE_TABLA = re.compile(r"CREATE\s+TABLE\s+(?:IF\s+NOT\s+EXISTS\s+)?`?(\w+)`?", re.IGNORECASE)
UMBRAL = 0.4


def tablas(texto):
    return {t.lower() for t in RE_TABLA.findall(texto)}


def main():
    train = {}
    preguntas_train = set()
    for archivo in ("train.jsonl", "dev_interno.jsonl"):
        for linea in open(RAIZ / "datos/entrenamiento" / archivo, encoding="utf-8"):
            e = json.loads(linea)
            usuario = e["messages"][1]["content"]
            train.setdefault(e["db_id"], tablas(usuario))
            preguntas_train.add(usuario.split("### Pregunta\n")[-1].strip().lower())

    problemas = 0
    carpetas = sorted(d for d in (RAIZ / "datos/validacion").iterdir()
                      if (d / "esquema.sql").exists())
    if len(carpetas) < 2:
        print(f"AVISO: hay {len(carpetas)} esquemas de validación; se piden al menos 2.")
    for d in carpetas:
        tv = tablas((d / "esquema.sql").read_text(encoding="utf-8"))
        if d.name in train:
            print(f"FUGA: la base '{d.name}' está en el entrenamiento")
            problemas += 1
        for db, tt in train.items():
            j = len(tv & tt) / max(len(tv | tt), 1)
            if j >= UMBRAL:
                print(f"FUGA: '{d.name}' comparte tablas con '{db}' (Jaccard {j:.2f}): {sorted(tv & tt)}")
                problemas += 1
        pares = d / "preguntas.json"
        if pares.exists():
            for p in json.loads(pares.read_text(encoding="utf-8")):
                if p["pregunta"].strip().lower() in preguntas_train:
                    print(f"FUGA: pregunta repetida en entrenamiento: {p['pregunta'][:80]}")
                    problemas += 1
        print(f"{d.name}: {len(tv)} tablas revisadas")
    print("OK: sin fuga" if not problemas else f"{problemas} problema(s)")
    sys.exit(1 if problemas else 0)


if __name__ == "__main__":
    main()
