# Esquemas propios (datos de entrenamiento)

Esquemas diseñados para el proyecto, con pares pregunta–SQL **generados con un LLM**
(Claude, vía Claude Code) y **validados por ejecución** en MySQL 8.4.10 con
`scripts/datos/04_validar_propios.py`. Su objetivo es cubrir lo que Spider no trae
y que sí aparece en la evaluación oculta:

- nombres de tablas y columnas en español, en inglés y **abreviados** (`cli_id`, `fec_ped`, `emp`);
- `COMMENT` en tablas y columnas, como los devuelve `SHOW CREATE TABLE`;
- fechas (`YEAR`, `MONTH`, `DATE_FORMAT`, `DATEDIFF`, `TIMESTAMPDIFF`, `DATE_SUB`, rangos);
- `WITH` (CTE), funciones de ventana (`ROW_NUMBER`, `RANK`, `DENSE_RANK`, `LAG`, `SUM() OVER`);
- subconsultas correlacionadas, `EXISTS`, `HAVING`, `ONLY_FULL_GROUP_BY`.

> ⚠️ Estos esquemas **no pueden usarse como validación**. Los esquemas de validación
> (`datos/validacion/`) deben ser de dominios distintos a todos los de esta carpeta y
> a los de Spider (penalización de −15). `scripts/evaluacion/verificar_fuga.py` lo revisa.

## Formato de cada carpeta `<nombre>/`

| Archivo | Contenido |
|---|---|
| `esquema.sql` | 5–10 `CREATE TABLE` con PK, FK y `COMMENT` en cada tabla y columna. |
| `datos.sql` | `INSERT` con datos realistas (≈15–60 filas por tabla, fechas 2022–2025). |
| `pares.json` | Lista de `{"pregunta", "sql", "nivel"}`; nivel ∈ `facil`, `media`, `dificil`. |

Reglas para los pares:

- Pregunta en español natural que **indique qué columnas devolver**.
- `facil`: una tabla. `media`: JOIN, GROUP BY, HAVING. `dificil`: subconsultas, WITH,
  ventana, fechas.
- SQL de solo lectura que cumpla `ONLY_FULL_GROUP_BY` y no use `NOW()`/`CURDATE()` (los
  resultados dependerían del día).
- `ORDER BY` solo si la pregunta pide orden o top N.
