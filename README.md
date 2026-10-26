# Proyecto 3 — Text-to-SQL con LoRA

Deep Learning 2026, Universidad del Valle de Guatemala.
Integrantes: **Anggie Quezada** (`Qu3zada22`) y **Iris Ayala** (`[usuario-github]`).

Fine-tuning con LoRA de **Qwen/Qwen2.5-Coder-1.5B-Instruct** para que, dado el esquema de una
base MySQL (`SHOW CREATE TABLE`, con `COMMENT`) y una pregunta en español, genere una consulta
**MySQL 8.4** correcta.

## Uso rápido (como lo corre el evaluador)

```bash
pip install -r requirements.txt
```
```python
from solucion import generar_sql        # carga config.json: modelo base + adapter/
sql = generar_sql(esquema, "¿Cuántos clientes hay por país? Devuelve país y total.", ejecutar)
```

- `config.json` → `"usar_adapter": false` usa el modelo base con **el mismo prompt**.
- Generación determinista: greedy (`do_sample=False`, `num_beams=1`) y `semilla` fija.
- Siempre devuelve **una sola** sentencia `SELECT` o `WITH … SELECT`. Si el modelo genera otra
  cosa (DML, DDL, `INTO OUTFILE`, varias sentencias), se devuelve `SELECT 1`, así que nunca se
  modifica la base.
- Si se entrega `ejecutar`, la consulta se prueba y, si MySQL da error, el modelo la corrige con
  el mensaje de error (máximo 3 llamadas, con presupuesto de tiempo para no pasar de 30 s).
- El esquema se compacta antes de entrar al prompt (sin `ENGINE`, `COLLATE`, índices
  secundarios ni `DEFAULT NULL`; se conservan columnas, tipos, PK, FK y `COMMENT`).

## Estructura

```
solucion.py, config.json, requirements.txt, adapter/   entrega (contrato del proyecto)
configs/                    baseline / LoRA A / LoRA B (para nuestra evaluación, vía T2S_CONFIG)
scripts/comun.py            conexión MySQL, ejecución con categoría de error, SHOW CREATE TABLE
scripts/datos/              01 descarga Spider · 02 Spider→MySQL · 03 traducción · 04 esquemas propios · 05 dataset
scripts/entrenamiento/      entrenar.py (LoRA A/B)
scripts/evaluacion/         verificar_fuga.py, evaluar.py
datos/esquemas_propios/     12 esquemas propios + pares generados con LLM
datos/procesados/           pares válidos y esquemas (SHOW CREATE TABLE)
datos/entrenamiento/        train.jsonl / dev_interno.jsonl en formato chat
datos/validacion/           2 esquemas no vistos + 40 preguntas propias
datos/descartes/            todo par descartado, con su motivo
notebooks/                  Colab: entrenamiento y evaluación
resultados/                 curvas de loss, validacion_propia.csv, análisis de errores
```

## Cómo reproducir

### 0. MySQL 8.4.10
```bash
docker compose up -d          # mysql:8.4.10, puerto 3307, root/root, configuración por defecto
python -m venv .venv && .venv/bin/pip install -r requirements.txt torch
```

### 1. Datos
```bash
bash scripts/datos/01_descargar_spider.sh              # Spider 1.0 + checksum
.venv/bin/python scripts/datos/02_spider_a_mysql.py    # carga 166 bases y valida consultas en MySQL
.venv/bin/python scripts/datos/03_traducir_spider.py   # preguntas al español (MarianMT)
.venv/bin/python scripts/datos/04_validar_propios.py   # esquemas propios
.venv/bin/python scripts/datos/05_construir_dataset.py # formato chat con el prompt de solucion.py
```

### 2. Entrenamiento (Colab, T4)
Se entrena en Google Colab con GPU T4 (en una computadora sin GPU no es viable):

1. Abrir `notebooks/02_entrenamiento.ipynb` en Colab (desde GitHub o *Subir cuaderno*).
2. *Entorno de ejecución → Cambiar tipo → T4 GPU*.
3. Guardar un token de GitHub (acceso de lectura y escritura a este repo) en *Secrets* como
   `GH_TOKEN`. Si los Secrets no están disponibles (p. ej. con la extensión de Colab para VS Code),
   el notebook pide el token en un cuadro de texto.
4. *Ejecutar todas*. El notebook monta Google Drive, clona el repo, entrena A y B con
   `scripts/entrenamiento/entrenar.py` y sube los resultados de cada configuración al repo apenas
   termina.

Los checkpoints se guardan cada 50 pasos en `MyDrive/t2s_checkpoints/<config>/`. Si Colab se
desconecta, volver a ejecutar el notebook continúa desde el último checkpoint, y una configuración
que ya está en el repo no se vuelve a entrenar.

Fuera del notebook: `python scripts/entrenamiento/entrenar.py --config A|B --checkpoints <carpeta>`.
El adapter elegido se copia a `adapter/`.

A se entrenó en tres sesiones (un corte de luz en el paso ~250 y el límite de uso de Colab en el
paso ~380) y se reanudó desde los checkpoints 250 y 400; el historial de loss quedó completo.

| Config | Módulos con LoRA | Parámetros entrenables | Pasos | Tiempo por paso (T4) | Loss dev final |
|---|---|---|---|---|---|
| A | atención (`q, k, v, o`) | 4,358,144 (0.282 %) | 495 | ~23 s (~3 h en total, en 3 sesiones) | 0.1174 (perplejidad 1.125) |
| B | atención + MLP (`gate, up, down`) | 18,464,768 (1.182 %) | 495 | ~23 s (189 min en total) | 0.0997 (perplejidad 1.105) |

### 3. Evaluación
`T2S_CONFIG=configs/baseline.json python scripts/evaluacion/evaluar.py` (ver `PLAN_TRABAJO.md`).

## Dataset

| Fuente | Pares | Notas |
|---|---|---|
| Spider 1.0 (train + others + dev), 166 bases | 9,693 → 9,516 válidos en MySQL → 8,261 traducidos | 6,000 muestreados para entrenar |
| Esquemas propios (12) | 960 (25 fáciles / 30 medios / 25 difíciles por esquema) | generados con LLM, todos validados por ejecución; ×2 en el entrenamiento |
| **Total entrenamiento** | **6,960 pares únicos, 7,920 ejemplos, 169 esquemas** | `datos/entrenamiento/resumen.json` |

Descartes:

| Etapa | Descartados | Motivo principal |
|---|---|---|
| Spider → MySQL | 177 | 91 `ONLY_FULL_GROUP_BY`, 25 duplicados, 24 ORDER BY fuera de DISTINCT, 11 derivada sin alias, 26 otros |
| Traducción | 1,255 | el traductor alteró un valor literal de la consulta |
| Largo | 63 | más de 3,072 tokens (esquemas muy grandes de Spider) |
| Esquemas propios | 0 | — |

Solo se aceptan pares cuya consulta corre sin error en MySQL 8.4.10. Los descartes, con su
motivo, están en `datos/descartes/`.

## Resultados

*(por completar: baseline, LoRA A, LoRA B, experimento de inferencia, análisis de errores,
predicción de EX)*

## Licencias

| Recurso | Licencia |
|---|---|
| Qwen/Qwen2.5-Coder-1.5B-Instruct | Apache 2.0 |
| Spider 1.0 (Yu et al., 2018) | CC BY-SA 4.0. Los pares derivados en `datos/` se comparten bajo la misma licencia |
| Helsinki-NLP/opus-mt-en-es (traducción) | Apache 2.0 |
| MySQL 8.4 Community (imagen `mysql:8.4.10`) | GPL v2 |

## Uso de IA

- **Generación de datos:** Apoyo
- **Traducción:** las preguntas de Spider se tradujeron con MarianMT (`opus-mt-en-es`), un
  modelo local.
- **Código y documentación:** usamos Claude Code como asistente para escribir los scripts y la
  documentación. Revisamos, ejecutamos y entendemos todo el código entregado.
- **En la inferencia no se usa ninguna API externa:** `solucion.py` solo usa el modelo base
  permitido y nuestro adapter LoRA.
- Las 40 preguntas de validación propia las escribimos nosotras.
