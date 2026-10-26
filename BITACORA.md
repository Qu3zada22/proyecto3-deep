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

### 2026-10-25 — Iris Ayala
**Configuración B y esquemas de validación.** Corrimos el entrenamiento de la configuración B
(atención + MLP) en Colab T4 desde otra cuenta, en paralelo con A, con `CONFIGS = ['B']` en el
notebook. Para la validación propia creamos dos esquemas de dominios que no están en el
entrenamiento: `gimnasio` (9 tablas, nombres en español) y `cooperativa_cafe` (9 tablas, nombres
abreviados como `prod`, `fca`, `lot`, `cat`, `vta_det`), ambos con `COMMENT` en tablas y
columnas y datos de 2022–2025. `cargar_validacion.py` los carga en MySQL 8.4.10 como
`val_<nombre>` y crea el usuario de solo lectura `lector`. `verificar_fuga.py`: sin fuga.

### 2026-10-25 — Iris Ayala
**40 preguntas de validación.** 20 por esquema (7 fáciles, 7 medias, 6 difíciles; pesos
1/2/3), cada una indica qué columnas devolver y solo dos piden orden. Ejecutamos todo
el SQL de referencia en MySQL 8.4.10: dos preguntas ("socios sin clases" y "clientes sin
compras") devolvían 0 filas, lo que haría que cualquier consulta vacía acertara, así que
agregamos 3 socios y 2 clientes a los datos para que tengan respuesta.

### 2026-10-25 — Iris Ayala
**Evaluador y notebook de evaluación.** `evaluar.py` imita al evaluador del docente: entrega
el esquema como `SHOW CREATE TABLE`, ofrece `ejecutar(sql)` con el usuario de solo lectura
(máximo 10 filas y 3 llamadas), compara por ejecución con números redondeados a 2 decimales,
filas como multiconjunto (en orden solo si la pregunta lo pide) y permite columnas adicionales,
y cuenta como error pasar de 30 s o devolver algo que no sea SELECT/WITH. Con `--oraculo`
(responde con la consulta de referencia) da EX = 1.000, lo que confirma que el comparador
funciona. Como Colab no tiene Docker, `instalar_mysql_colab.sh` instala el binario de MySQL
8.4.10 en el puerto 3307; `03_evaluacion.ipynb` evalúa baseline, A y B, y la mejor sin
`ejecutar` como experimento de inferencia.

### 2026-10-25 — Iris Ayala
**Evaluación, análisis de errores y adapter final.** EX ponderada en la validación propia:
baseline 0.474, A 0.577 y B 0.590 (fáciles 14/14 en las tres; B gana en las medias, 10/14).
Se confirma la hipótesis y B queda en `adapter/` (+0.116 sobre el baseline); probamos que
`solucion.py` lo carga con `config.json`. Experimento de inferencia: B sin `ejecutar` también da
0.590; la autocorrección arregló un error de columna, pero la consulta corregida devolvió otro
resultado, y los errores restantes son lógicos (MySQL no los marca). Clasificamos a mano los 12
errores de B: agregación 5, columna inexistente 3 (todas en el esquema abreviado, por saltarse
la tabla intermedia `lot`), filtro 2, JOIN 1, resultado distinto 1 y sintaxis 0. Predicción de
EX en la evaluación oculta: ≈ 0.55 (rango 0.48–0.62).
