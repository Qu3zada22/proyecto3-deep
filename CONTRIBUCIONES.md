# Contribuciones

| Tarea | Responsable | Evidencia |
|---|---|---|
| Plan de trabajo y estructura del repositorio | Anggie Quezada | `PLAN_TRABAJO.md`, commits de `Qu3zada22` |
| `solucion.py` (prompt, filtro SELECT, autocorrección, límites de tiempo) | Anggie Quezada | `solucion.py` |
| **Datos:** Spider → MySQL 8.4.10 y reporte de descartes | Anggie Quezada | `scripts/datos/02_spider_a_mysql.py`, `datos/descartes/` |
| **Datos:** traducción al español | Anggie Quezada | `scripts/datos/03_traducir_spider.py`, `datos/procesados/spider_es.jsonl` |
| **Datos:** 12 esquemas propios con pares generados por LLM | Anggie Quezada | `datos/esquemas_propios/`, `scripts/datos/04_validar_propios.py` |
| **Datos:** dataset final en formato chat | Anggie Quezada | `scripts/datos/05_construir_dataset.py`, `datos/entrenamiento/` |
| **Entrenamiento:** configuraciones LoRA A y B, entrenamiento de A | Anggie Quezada | `scripts/entrenamiento/entrenar.py`, `resultados/entrenamiento/A/` |
| **Entrenamiento:** corrida de la configuración B en Colab | Iris Ayala | `resultados/entrenamiento/B/`, commits de `AleWWH1104` |
| **Validación:** 2 esquemas y 40 preguntas | Iris Ayala | `datos/validacion/`, `scripts/evaluacion/cargar_validacion.py` |
| **Validación:** evaluador por exactitud de ejecución y notebook de evaluación | Iris Ayala | `scripts/evaluacion/evaluar.py`, `scripts/evaluacion/instalar_mysql_colab.sh`, `notebooks/03_evaluacion.ipynb` |
| **Validación:** evaluación de baseline, A y B, y elección del adapter (B) | Iris Ayala | `resultados/validacion_propia.csv`, `adapter/` |
| **Errores:** experimento de inferencia y análisis por categoría | Iris Ayala | `resultados/errores_lora_B.csv`, `resultados/*.png`, `scripts/evaluacion/graficar.py` |
| Verificación de fuga validación/entrenamiento | Anggie Quezada | `scripts/evaluacion/verificar_fuga.py` |
| Prueba final de la entrega (`solucion.py` con `adapter/`) | Iris Ayala | `solucion.py`, `config.json`, `adapter/` |
| Predicción de EX y presentación | Ambas | `presentacion.pdf` |
