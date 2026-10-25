"""Traduce al español las preguntas de Spider con MarianMT (Helsinki-NLP/opus-mt-en-es).

Los valores literales de la consulta (p. ej. 'France', 2014) deben seguir
apareciendo en la pregunta traducida; si el traductor los cambia, se reintenta
poniéndolos entre comillas y, si aun así se pierden, el par se descarta.

Entrada:  datos/procesados/spider_mysql.jsonl
Salidas:  datos/procesados/spider_es.jsonl
          datos/descartes/traduccion_descartes.csv
Uso:      .venv/bin/python scripts/datos/03_traducir_spider.py
"""
import csv
import json
import re
from pathlib import Path

import torch
from tqdm import tqdm
from transformers import MarianMTModel, MarianTokenizer

RAIZ = Path(__file__).resolve().parents[2]
ENTRADA = RAIZ / "datos/procesados/spider_mysql.jsonl"
SALIDA = RAIZ / "datos/procesados/spider_es.jsonl"
DESCARTES = RAIZ / "datos/descartes/traduccion_descartes.csv"
MODELO = "Helsinki-NLP/opus-mt-en-es"
LOTE = 32

if torch.cuda.is_available():
    DISPOSITIVO = "cuda"
elif torch.backends.mps.is_available():
    DISPOSITIVO = "mps"
else:
    DISPOSITIVO = "cpu"

tok = MarianTokenizer.from_pretrained(MODELO)
modelo = MarianMTModel.from_pretrained(MODELO).to(DISPOSITIVO).eval()


def traducir(textos):
    salida = []
    for i in tqdm(range(0, len(textos), LOTE), desc="traducir"):
        lote = tok(textos[i:i + LOTE], return_tensors="pt", padding=True,
                   truncation=True, max_length=256).to(DISPOSITIVO)
        with torch.inference_mode():
            gen = modelo.generate(**lote, num_beams=4, max_new_tokens=256)
        salida += tok.batch_decode(gen, skip_special_tokens=True)
    return salida


def literales(sql, pregunta):
    """Literales de texto y números de la consulta que aparecen en la pregunta."""
    textos = [m.replace("''", "'") for m in re.findall(r"'((?:[^']|'')*)'", sql)]
    textos = [t.strip("%") for t in textos]
    nums = re.findall(r"(?<![\w.])\d+(?:\.\d+)?(?![\w.])", re.sub(r"'(?:[^']|'')*'", "", sql))
    p = pregunta.lower()
    return [x for x in textos + nums if x and x.lower() in p]


def conserva(traduccion, lits):
    t = traduccion.lower()
    return all(x.lower() in t for x in lits)


def main():
    pares = [json.loads(l) for l in ENTRADA.open()]
    preguntas = [p["question"].strip() for p in pares]
    lits = [literales(p["sql_mysql"], q) for p, q in zip(pares, preguntas)]

    es = traducir(preguntas)

    # reintento: literales entre comillas para que el traductor no los toque
    fallidos = [i for i, (t, l) in enumerate(zip(es, lits)) if not conserva(t, l)]
    print(f"Reintentando {len(fallidos)} traducciones que perdieron literales")
    reintento = []
    for i in fallidos:
        q = preguntas[i]
        for x in sorted(lits[i], key=len, reverse=True):
            q = re.sub(re.escape(x), lambda m: f'"{m.group(0)}"', q, count=1, flags=re.IGNORECASE)
        reintento.append(q)
    for i, t in zip(fallidos, traducir(reintento)):
        es[i] = t

    validos, descartes = [], []
    for p, t, l in zip(pares, es, lits):
        if conserva(t, l):
            validos.append({**p, "pregunta": t})
        else:
            descartes.append({"id": p["id"], "db_id": p["db_id"], "question": p["question"],
                              "traduccion": t, "literales": "|".join(l),
                              "motivo": "traduccion_perdio_literal"})

    with SALIDA.open("w") as f:
        for v in validos:
            f.write(json.dumps(v, ensure_ascii=False) + "\n")
    with DESCARTES.open("w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=["id", "db_id", "question", "traduccion",
                                          "literales", "motivo"])
        w.writeheader()
        w.writerows(descartes)
    print(f"traducidos: {len(validos)}  descartados: {len(descartes)}")


if __name__ == "__main__":
    main()
