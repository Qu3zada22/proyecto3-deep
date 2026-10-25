# Bitácora

Cada entrada lleva fecha y autora. Mínimo 8 entradas (requisito del proyecto).

---

### 2026-10-22 — Anggie Quezada
**Planificación y estructura.** Leímos el enunciado y definimos la división de trabajo
(`PLAN_TRABAJO.md`): Anggie se encarga de datos y entrenamiento, [Compañera] de validación y
análisis de errores. Creamos la estructura del repositorio, `config.json`, `requirements.txt` y
un `docker-compose.yml` con MySQL 8.4.10 (configuración por defecto, `ONLY_FULL_GROUP_BY`
activo, nombres de tabla sensibles a mayúsculas como en Linux).

### 2026-10-22 — Anggie Quezada
**`solucion.py`.** Implementamos `generar_sql` con generación greedy (`do_sample=False`) y
semilla fija, un filtro que solo deja salir una sentencia SELECT/WITH (si no, devuelve
`SELECT 1`, así nunca se modifica la base) y autocorrección con `ejecutar` (máx. 3 llamadas,
con presupuesto de tiempo para no pasar de 30 s). El esquema se compacta (sin ENGINE, COLLATE,
índices ni `DEFAULT NULL`, pero con PK, FK y COMMENT): ~37 % menos tokens.

### 2026-10-22 — Anggie Quezada
**Spider → MySQL.** Descargamos Spider 1.0 (checksum verificado) y cargamos sus 166 bases
SQLite en MySQL con tipos MySQL, PK y FK (`scripts/datos/02_spider_a_mysql.py`). Las consultas
se traducen de SQLite a MySQL con sqlglot (comillas dobles → simples, `||` → `CONCAT`) y se
ejecutan en MySQL 8.4.10. De 9,693 pares quedaron 9,516; se descartaron 177
(91 por `ONLY_FULL_GROUP_BY`, 25 duplicados, 24 por ORDER BY fuera de DISTINCT, otros en
`datos/descartes/spider_resumen.json`).

### 2026-10-22 — Anggie Quezada
**Traducción y esquemas propios.** Traducimos las preguntas al español con MarianMT
(`Helsinki-NLP/opus-mt-en-es`) y verificamos que los valores literales de la consulta sigan en
la pregunta. Si el traductor los cambia ("English" → "Inglés"), se reintenta con el valor entre
comillas, y si aun así se pierden, el par se descarta: quedaron 8,261 y se descartaron 1,255.
Generamos con un LLM 12 esquemas propios de 8–9 tablas (nombres en español, en inglés y
abreviados, con COMMENT, fechas, CTE y funciones de ventana), con 80 pares cada uno
(25 fáciles, 30 medios, 25 difíciles): 960 pares, todos válidos en MySQL y ninguno con 0 filas.

### 2026-10-22 — Anggie Quezada
**Dataset final.** Los esquemas con COMMENT miden 1,500–2,500 tokens, y con el límite inicial
de 2,048 se perdían 553 de los 960 pares propios. Subimos el límite a 3,072 tokens.
Resultado: 6,000 pares de Spider (muestreados) + 960 propios ×2 = 7,920 ejemplos de 169
esquemas. El dev interno para la curva de loss usa 302 pares de 8 bases de Spider apartadas
**por esquema**. Mediana de 704 tokens por ejemplo, p95 de 2,290.
