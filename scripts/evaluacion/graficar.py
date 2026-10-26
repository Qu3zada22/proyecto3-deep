"""Gráficas de la validación propia a partir de resultados/validacion_propia.csv.

  resultados/ex_por_config.png     EX ponderada y aciertos por nivel de cada configuración
  resultados/errores_lora_B.png    errores del mejor adapter por categoría (resultados/errores_lora_B.csv,
                                   clasificados a mano a partir de la SQL generada)
Uso: .venv/bin/python scripts/evaluacion/graficar.py
"""
import csv
from collections import Counter, defaultdict
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt  # noqa: E402

RAIZ = Path(__file__).resolve().parents[2]
RES = RAIZ / "resultados"
NIVELES = ["facil", "media", "dificil"]
ORDEN = ["baseline", "lora_A", "lora_B", "lora_B_sin_ejecutar"]
CATEGORIAS = ["sintaxis", "columna_inexistente", "join", "agregacion", "filtro", "resultado_distinto"]


def main():
    filas = list(csv.DictReader(open(RES / "validacion_propia.csv", encoding="utf-8")))
    por_config = defaultdict(list)
    for f in filas:
        por_config[f["config"]].append(f)
    configs = [c for c in ORDEN if c in por_config]

    def ex(fs):
        return sum(int(f["peso"]) for f in fs if f["acierto"] == "1") / sum(int(f["peso"]) for f in fs)

    fig, (a1, a2) = plt.subplots(1, 2, figsize=(11, 4))
    valores = [ex(por_config[c]) for c in configs]
    barras = a1.bar(configs, valores, color=["#9aa5b1", "#5b8def", "#1f4fbf", "#7fa7f5"][:len(configs)])
    a1.bar_label(barras, fmt="%.3f")
    a1.set_ylim(0, 1)
    a1.set_ylabel("EX ponderada")
    a1.set_title("EX en la validación propia (40 preguntas)")
    a1.tick_params(axis="x", rotation=15)
    ancho = 0.8 / len(configs)
    for i, c in enumerate(configs):
        tasas = []
        for n in NIVELES:
            fs = [f for f in por_config[c] if f["nivel"] == n]
            tasas.append(sum(f["acierto"] == "1" for f in fs) / len(fs))
        a2.bar([j + i * ancho for j in range(3)], tasas, ancho, label=c)
    a2.set_xticks([j + ancho * (len(configs) - 1) / 2 for j in range(3)], NIVELES)
    a2.set_ylim(0, 1.05)
    a2.set_ylabel("aciertos / preguntas")
    a2.set_title("Aciertos por nivel")
    a2.legend(fontsize=8)
    fig.tight_layout()
    fig.savefig(RES / "ex_por_config.png", dpi=150)

    errores = Counter(r["categoria"] for r in csv.DictReader(
        open(RES / "errores_lora_B.csv", encoding="utf-8")))
    fig, ax = plt.subplots(figsize=(7, 3.5))
    barras = ax.barh(CATEGORIAS[::-1], [errores.get(c, 0) for c in CATEGORIAS[::-1]], color="#1f4fbf")
    ax.bar_label(barras)
    ax.set_xlabel("preguntas")
    ax.set_title(f"Errores de LoRA B por categoría ({sum(errores.values())} de 40)")
    fig.tight_layout()
    fig.savefig(RES / "errores_lora_B.png", dpi=150)
    print("Gráficas en resultados/")


if __name__ == "__main__":
    main()
