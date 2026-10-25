# Plan de trabajo y división de tareas

Entrega: **domingo 25 de octubre de 2026, 23:59**. Integrantes: **Anggie Quezada** (`Qu3zada22`)
y **[Compañera]** (`[usuario-github]`).

El enunciado exige que cada integrante sea responsable de al menos un área (datos,
entrenamiento, o validación y errores) y que **ambas hagan commits desde su propia cuenta**.
La división busca que las dos trabajen en paralelo sin bloquearse:

| Área | Responsable | Entregables |
|---|---|---|
| **Datos** | Anggie | pipeline Spider → MySQL → español, 12 esquemas propios, `datos/`, reporte de descartes |
| **Entrenamiento** | Anggie | `scripts/entrenamiento/entrenar.py`, configuraciones A y B, hipótesis, curvas de loss, `adapter/` final |
| **Validación y errores** | [Compañera] | 2 esquemas de validación + 40 preguntas, evaluador EX, baseline, experimento de inferencia, análisis de errores, `resultados/validacion_propia.csv` |
| **Entrega** | Ambas | prueba en Colab T4, predicción de EX, `presentacion.pdf`, README, BITACORA, `historial_git.txt` |

## Cronograma

| Día | Anggie | [Compañera] |
|---|---|---|
| Jue 22 | Estructura del repo, `solucion.py`, pipeline de datos, esquemas propios | Diseñar los 2 esquemas de validación (dominios **distintos** a los de entrenamiento) |
| Vie 23 | Construir dataset; entrenar A y B en Colab | 40 preguntas + SQL de referencia; evaluador `scripts/evaluacion/evaluar.py`; **baseline** |
| Sáb 24 | Elegir adapter, copiarlo a `adapter/`, probar tiempos en T4 | Evaluar A y B; experimento de inferencia; análisis de errores |
| Dom 25 | Presentación (datos y entrenamiento), README | Presentación (validación y errores), predicción de EX |

## Tareas de [Compañera]: validación y errores

### 1. Esquemas de validación (`datos/validacion/<nombre>/`)
- **Dos** esquemas de 5 a 10 tablas cada uno, de dominios que NO estén en el entrenamiento.
  Ya se usan en entrenamiento: `tienda_linea`, `banco`, `hr_company`, `streaming`,
  `universidad`, `hospital`, `logistica`, `restaurante`, `liga_futbol`, `inventario`,
  `hotel`, `sales_crm` y las 166 bases de Spider (`datos/procesados/esquemas_spider/`).
  Sugerencias: **gimnasio / centro deportivo** y **cooperativa agrícola de café**.
- Imitar la evaluación oculta: uno con nombres en español y otro con nombres abreviados o en
  inglés, con `COMMENT` en tablas y columnas.
- Archivos: `esquema.sql`, `datos.sql` (mismo formato que `datos/esquemas_propios/`).
- Correr `scripts/evaluacion/verificar_fuga.py`: debe decir `OK: sin fuga`.

### 2. 40 preguntas propias (`datos/validacion/<nombre>/preguntas.json`)
Escritas por ustedes (no generadas con un LLM), repartidas en los tres niveles:
```json
{"id": "gim_01", "nivel": "facil", "pregunta": "...", "sql_referencia": "SELECT ...", "ordenado": false}
```
`ordenado: true` solo si la pregunta pide un orden. Cada pregunta debe decir qué columnas devolver.

### 3. Evaluador (`scripts/evaluacion/evaluar.py`)
Debe imitar al del docente:
- importa `solucion.generar_sql` (con `T2S_CONFIG=<ruta>` se elige baseline / A / B sin
  editar `config.json`; ver `configs/`);
- le pasa `esquema` = `SHOW CREATE TABLE` de cada tabla (`scripts/comun.py: esquema_de_base`);
- le pasa `ejecutar(sql)` → `{ok, columnas, filas (máx. 10), error}`, con usuario de **solo
  lectura** y máximo 3 llamadas por pregunta (permitir apagarlo para el experimento);
- compara por **ejecución**: números redondeados a 2 decimales, filas como multiconjunto
  (en orden solo si `ordenado`), y una columna adicional no penaliza;
- mide tiempo por pregunta (límite de 30 s) y verifica que la salida sea SELECT/WITH;
- calcula **EX ponderada** (fácil 1, media 2, difícil 3) y la guarda en
  `resultados/validacion_propia.csv`, con columnas `config, id, nivel, peso, pregunta,
  sql_referencia, sql_generada, acierto, categoria_error, tiempo_s`.

### 4. Experimentos y análisis
- **Baseline**: `usar_adapter: false` sobre la validación propia.
- **Experimento de inferencia**: con y sin `ejecutar` (autocorrección), con el mejor adapter.
- **Análisis de errores** por categoría: sintaxis, columna o tabla inexistente, JOIN,
  agregación, filtro, resultado distinto. Tabla y gráfica en `resultados/`.
- **Predicción justificada** de la EX en la evaluación oculta.
