"""Arma el dataset de entrenamiento en formato chat, con el MISMO prompt de solucion.py.

Entradas:
  datos/procesados/spider_es.jsonl          + esquemas_spider/<db>.sql
  datos/procesados/propios.jsonl            + esquemas_propios/<db>.sql
Salidas:
  datos/entrenamiento/train.jsonl           {"messages": [...], "fuente", "db_id", "id"}
  datos/entrenamiento/dev_interno.jsonl     bases de Spider apartadas (curva de loss de validación)
  datos/entrenamiento/resumen.json
  datos/descartes/dataset_descartes.csv     pares que superan MAX_TOKENS

La partición train / dev_interno es POR ESQUEMA. La validación propia del
proyecto (datos/validacion/) no se usa aquí en absoluto.

Uso: .venv/bin/python scripts/datos/05_construir_dataset.py
"""
import csv
import json
import os
import random
import sys
from collections import Counter
from pathlib import Path

from transformers import AutoTokenizer

RAIZ = Path(__file__).resolve().parents[2]
os.environ["T2S_NO_CARGAR_MODELO"] = "1"
sys.path.insert(0, str(RAIZ))
from solucion import CONFIG, construir_mensajes  # noqa: E402

PROC = RAIZ / "datos/procesados"
SALIDA = RAIZ / "datos/entrenamiento"
SEMILLA = 2026
MAX_TOKENS = 3072          # prompt + respuesta (los esquemas con COMMENT miden 1.5–2.5k)
N_DBS_DEV = 8              # bases de Spider apartadas para el loss de validación
MAX_SPIDER = 6000          # tope de pares de Spider (tiempo de entrenamiento en T4)
REPETIR_PROPIOS = 2        # sobremuestreo de los esquemas propios (español, COMMENT, fechas)


def leer(ruta):
    return [json.loads(l) for l in open(ruta, encoding="utf-8")]


def main():
    rnd = random.Random(SEMILLA)
    tok = AutoTokenizer.from_pretrained(CONFIG["modelo_base"])
    esquemas = {}

    def esquema(carpeta, db):
        if (carpeta, db) not in esquemas:
            esquemas[(carpeta, db)] = (PROC / carpeta / f"{db}.sql").read_text(encoding="utf-8")
        return esquemas[(carpeta, db)]

    spider = leer(PROC / "spider_es.jsonl")
    propios = leer(PROC / "propios.jsonl") if (PROC / "propios.jsonl").exists() else []

    ejemplos = []
    for p in spider:
        ejemplos.append(dict(id=p["id"], fuente="spider", db_id=p["db_id"],
                             esquema=esquema("esquemas_spider", p["db_id"]),
                             pregunta=p["pregunta"], sql=p["sql_mysql"]))
    for p in propios:
        ejemplos.append(dict(id=p["id"], fuente="propio", db_id=p["db_id"], nivel=p["nivel"],
                             esquema=esquema("esquemas_propios", p["db_id"]),
                             pregunta=p["pregunta"], sql=p["sql"]))

    validos, descartes = [], []
    for e in ejemplos:
        mensajes = construir_mensajes(e["esquema"], e["pregunta"]) + [
            {"role": "assistant", "content": e["sql"]}]
        n = len(tok.apply_chat_template(mensajes, tokenize=True))
        if n > MAX_TOKENS:
            descartes.append(dict(id=e["id"], db_id=e["db_id"], tokens=n, motivo="supera_max_tokens"))
            continue
        validos.append(dict(id=e["id"], fuente=e["fuente"], db_id=e["db_id"], tokens=n,
                            messages=mensajes))

    dbs_spider = sorted({e["db_id"] for e in validos if e["fuente"] == "spider"})
    dbs_dev = set(rnd.sample(dbs_spider, N_DBS_DEV))
    dev = [e for e in validos if e["fuente"] == "spider" and e["db_id"] in dbs_dev]
    sp_train = [e for e in validos if e["fuente"] == "spider" and e["db_id"] not in dbs_dev]
    pr_train = [e for e in validos if e["fuente"] == "propio"]
    rnd.shuffle(sp_train)
    sp_train = sp_train[:MAX_SPIDER]
    train = sp_train + pr_train * REPETIR_PROPIOS
    rnd.shuffle(train)

    SALIDA.mkdir(parents=True, exist_ok=True)
    for nombre, filas in (("train", train), ("dev_interno", dev)):
        with open(SALIDA / f"{nombre}.jsonl", "w", encoding="utf-8") as f:
            for e in filas:
                f.write(json.dumps(e, ensure_ascii=False) + "\n")
    with open(RAIZ / "datos/descartes/dataset_descartes.csv", "w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=["id", "db_id", "tokens", "motivo"])
        w.writeheader()
        w.writerows(descartes)

    tokens = sorted(e["tokens"] for e in train)
    resumen = dict(
        pares_unicos_train=len(sp_train) + len(pr_train),
        ejemplos_train=len(train), ejemplos_dev_interno=len(dev),
        spider_train=len(sp_train), propios_train=len(pr_train),
        repetir_propios=REPETIR_PROPIOS,
        esquemas_train=len({e["db_id"] for e in sp_train + pr_train}),
        bases_dev_interno=sorted(dbs_dev),
        descartados_por_largo=len(descartes),
        tokens_mediana=tokens[len(tokens) // 2], tokens_p95=tokens[int(len(tokens) * .95)],
        tokens_total=sum(tokens),
        propios_por_esquema=dict(Counter(e["db_id"] for e in pr_train)),
    )
    (SALIDA / "resumen.json").write_text(json.dumps(resumen, indent=2, ensure_ascii=False))
    print(json.dumps(resumen, indent=2, ensure_ascii=False))


if __name__ == "__main__":
    main()
