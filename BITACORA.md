# Bitácora

Cada entrada lleva fecha y autora. Mínimo 8 entradas (requisito del proyecto).

---

### 2026-10-22 — Anggie Quezada
**Planificación y estructura.** Leímos el enunciado y definimos la división de trabajo
(`PLAN_TRABAJO.md`): Anggie se encarga de datos y entrenamiento, Iris Ayala de validación y
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

### 2026-10-25 — Anggie Quezada
**Entrenamiento en Colab.** En la computadora local no había GPU ni espacio suficiente, así que el
entrenamiento se pasó a Colab (T4). `entrenar.py` ahora guarda checkpoints cada 50 pasos en
Google Drive y reanuda desde el último si la sesión se desconecta; el notebook sube cada
configuración al repo apenas termina. La extensión de Colab para VS Code no puede leer los
Secrets (`GH_TOKEN`), por lo que el notebook pide el token si no lo encuentra; al final se usó
Colab en el navegador. Configuración A: 4,358,144 parámetros entrenables (0.282 %), ~19 s por
paso, ~2 h 40 min para los 495 pasos. El loss de train arranca en ~0.29.

### 2026-10-25 — Anggie Quezada
**Configuraciones A y B terminadas.** Un corte de luz detuvo A cerca del paso 250 y luego Colab
cortó la sesión por duración máxima en el paso ~380; las dos veces se reanudó desde los
checkpoints en Drive (250 y 400), la última desde otra cuenta de Google porque se agotó la cuota
de GPU. Iris entrenó B en paralelo en su cuenta (189 min). Loss en dev interno: A 0.1174 y
B 0.0997, con B por debajo de A en todas las evaluaciones desde el paso 100. Se cumple la primera
parte de la hipótesis (menor loss con MLP); B tiene 4.2× más parámetros, no 2.5× como estimamos.
El dev de A se aplana desde el paso 200 y el de B desde el 400. Falta confirmar con la EX en la
validación propia cuál adapter queda en `adapter/`.
