"""Text-to-SQL en español -> MySQL 8.4 con Qwen2.5-Coder + adapter LoRA.

Contrato del proyecto:
    generar_sql(esquema: str, pregunta: str, ejecutar=None) -> str

- Carga el modelo indicado en config.json al importar el módulo.
- Generación determinista (greedy, do_sample=False, semilla fija).
- Siempre devuelve una sola consulta SELECT o WITH ... SELECT. Si el modelo
  produce otra cosa, se devuelve una consulta inofensiva (nunca algo que
  modifique la base).
- Si el evaluador entrega `ejecutar`, se usa para autocorregir la consulta
  cuando MySQL devuelve error (máximo 3 llamadas y 30 s por pregunta).

El mismo prompt se usa con y sin adapter ("usar_adapter" en config.json).
Las funciones de prompt (compactar_esquema, construir_mensajes) también las
usa el script que arma el dataset de entrenamiento, para que el formato sea
idéntico en entrenamiento e inferencia.
"""
import json
import os
import re
import time

DIR = os.path.dirname(os.path.abspath(__file__))

# ----------------------------------------------------------------- límites
TIEMPO_MAX_PREGUNTA = 30.0   # s, impuesto por el evaluador
MARGEN_SEGURIDAD = 4.0       # s que se reservan para no pasarse del límite
MAX_LLAMADAS_EJECUTAR = 3    # impuesto por el evaluador
MAX_TOKENS_NUEVOS = 320
CONSULTA_SEGURA = "SELECT 1"  # respuesta de último recurso (nunca modifica la base)

# ------------------------------------------------------------------ prompt
SISTEMA = (
    "Eres un experto en MySQL 8.4. Recibes el esquema de una base de datos "
    "(sentencias CREATE TABLE, con COMMENT que describen tablas y columnas) y una "
    "pregunta en español. Escribe UNA sola consulta MySQL, SELECT o WITH ... SELECT, "
    "que la responda.\n"
    "Reglas:\n"
    "- Usa solo tablas y columnas que existan en el esquema.\n"
    "- Respeta ONLY_FULL_GROUP_BY: toda columna no agregada del SELECT va en el GROUP BY.\n"
    "- Devuelve las columnas que pide la pregunta, en ese orden.\n"
    "- Usa ORDER BY solo si la pregunta pide un orden o un top N.\n"
    "- Responde únicamente con la consulta SQL, sin explicaciones."
)

PLANTILLA_USUARIO = "### Esquema\n{esquema}\n\n### Pregunta\n{pregunta}"

PLANTILLA_CORRECCION = (
    "Al ejecutar esa consulta, MySQL devolvió este error:\n{error}\n\n"
    "Corrige la consulta. Responde únicamente con la consulta SQL corregida."
)

_RE_OPCIONES_TABLA = re.compile(r"\)\s*ENGINE=[^;]*;?\s*$", re.IGNORECASE | re.DOTALL)
_RE_LINEA_INDICE = re.compile(r"^\s*(UNIQUE\s+|FULLTEXT\s+|SPATIAL\s+)?KEY\s", re.IGNORECASE)
_RE_COLLATE = re.compile(r"\s+(CHARACTER SET|COLLATE)\s+\w+", re.IGNORECASE)
_RE_CONSTRAINT = re.compile(r"^\s*CONSTRAINT\s+`[^`]*`\s+", re.IGNORECASE)


def compactar_esquema(esquema: str) -> str:
    """Quita ruido de SHOW CREATE TABLE (ENGINE, COLLATE, índices, DEFAULT NULL, AUTO_INCREMENT)
    y conserva columnas, tipos, PK, FK y COMMENT. Ahorra tokens y tiempo."""
    bloques = re.split(r";\s*(?=CREATE\s+TABLE)", esquema.strip(), flags=re.IGNORECASE)
    salida = []
    for bloque in bloques:
        bloque = bloque.strip().rstrip(";").strip()
        if not bloque:
            continue
        # SHOW CREATE TABLE pone una columna por línea y cierra con "\n) ENGINE=..."
        m = re.match(r"(CREATE\s+TABLE\s+[^\s(]+)\s*\((.*)\n\)(.*)$", bloque,
                     re.IGNORECASE | re.DOTALL)
        if not m:
            salida.append(bloque + ";")
            continue
        cabecera, cuerpo, opciones = m.group(1).strip(), m.group(2), m.group(3)
        comentario_tabla = re.search(r"COMMENT='((?:[^']|'')*)'", opciones)
        lineas = []
        for linea in cuerpo.split("\n"):
            linea = linea.strip().rstrip(",").strip()
            if not linea or _RE_LINEA_INDICE.match(linea):
                continue
            linea = _RE_CONSTRAINT.sub("", linea)
            linea = _RE_COLLATE.sub("", linea)
            linea = linea.replace(" DEFAULT NULL", "").replace(" AUTO_INCREMENT", "")
            lineas.append("  " + linea)
        texto = f"{cabecera} (\n" + ",\n".join(lineas) + "\n)"
        if comentario_tabla:
            texto += f" COMMENT='{comentario_tabla.group(1)}'"
        salida.append(texto + ";")
    return "\n\n".join(salida)


def construir_mensajes(esquema: str, pregunta: str):
    return [
        {"role": "system", "content": SISTEMA},
        {"role": "user", "content": PLANTILLA_USUARIO.format(
            esquema=compactar_esquema(esquema), pregunta=pregunta.strip())},
    ]


# -------------------------------------------------- limpieza y validación SQL
_RE_PROHIBIDAS = re.compile(
    r"\b(INSERT|UPDATE|DELETE|DROP|ALTER|CREATE|TRUNCATE|RENAME|GRANT|REVOKE|"
    r"LOCK|CALL|LOAD|INTO|OUTFILE|DUMPFILE)\b",
    re.IGNORECASE,
)


def _sin_literales(sql: str) -> str:
    sql = re.sub(r"'(?:[^'\\]|\\.|'')*'", "''", sql)
    sql = re.sub(r'"(?:[^"\\]|\\.)*"', '""', sql)
    return re.sub(r"`[^`]*`", "``", sql)


def es_solo_lectura(sql: str) -> bool:
    """True si es una sola sentencia SELECT o WITH ... SELECT."""
    cuerpo = _sin_literales(sql).strip().rstrip(";").strip()
    if not cuerpo or ";" in cuerpo:
        return False
    if not re.match(r"^\(?\s*(SELECT|WITH)\b", cuerpo, re.IGNORECASE):
        return False
    return not _RE_PROHIBIDAS.search(cuerpo)


def extraer_sql(texto: str) -> str:
    """Saca la consulta de la respuesta del modelo (quita ```sql, <think>, texto extra)."""
    texto = re.sub(r"<think>.*?</think>", "", texto, flags=re.DOTALL)
    bloque = re.search(r"```(?:sql|mysql)?\s*(.*?)```", texto, re.DOTALL | re.IGNORECASE)
    if bloque:
        texto = bloque.group(1)
    texto = texto.replace("```", "")
    inicio = re.search(r"\b(WITH|SELECT)\b", texto, re.IGNORECASE)
    if inicio:
        texto = texto[inicio.start():]
    # cortar en el primer ';' que no esté dentro de un literal
    en_comilla = None
    for i, c in enumerate(texto):
        if en_comilla:
            if c == en_comilla:
                en_comilla = None
        elif c in "'\"`":
            en_comilla = c
        elif c == ";":
            texto = texto[:i]
            break
    return re.sub(r"\s+", " ", texto).strip()


# ------------------------------------------------------------------ modelo
# T2S_CONFIG permite a nuestros scripts de evaluación usar otra config (baseline,
# adapter A o B) sin editar config.json. El evaluador del curso no la define.
with open(os.environ.get("T2S_CONFIG") or os.path.join(DIR, "config.json"), encoding="utf-8") as f:
    CONFIG = json.load(f)

_modelo = None
_tokenizer = None


def _cargar():
    global _modelo, _tokenizer
    import torch
    from transformers import AutoModelForCausalLM, AutoTokenizer, set_seed

    set_seed(int(CONFIG.get("semilla", 2026)))
    if torch.cuda.is_available():
        dispositivo, dtype = "cuda", torch.float16   # T4: sin bf16
    elif getattr(torch.backends, "mps", None) and torch.backends.mps.is_available():
        dispositivo, dtype = "mps", torch.float16
    else:
        dispositivo, dtype = "cpu", torch.float32

    nombre = CONFIG["modelo_base"]
    _tokenizer = AutoTokenizer.from_pretrained(nombre)
    modelo = AutoModelForCausalLM.from_pretrained(nombre, dtype=dtype)
    if CONFIG.get("usar_adapter", True):
        from peft import PeftModel
        ruta = CONFIG.get("adapter", "adapter/")
        if not os.path.isabs(ruta):
            ruta = os.path.join(DIR, ruta)
        modelo = PeftModel.from_pretrained(modelo, ruta)
        modelo = modelo.merge_and_unload()  # misma salida, inferencia más rápida
    _modelo = modelo.to(dispositivo).eval()


def _generar(mensajes, tiempo_max: float) -> str:
    import torch
    from transformers import GenerationConfig

    kwargs = {"enable_thinking": False} if "qwen3" in CONFIG["modelo_base"].lower() else {}
    prompt = _tokenizer.apply_chat_template(
        mensajes, tokenize=False, add_generation_prompt=True, **kwargs)
    entradas = _tokenizer(prompt, return_tensors="pt").to(_modelo.device)
    config_gen = GenerationConfig(
        do_sample=False, num_beams=1, max_new_tokens=MAX_TOKENS_NUEVOS,
        max_time=max(tiempo_max, 1.0), repetition_penalty=1.0,
        eos_token_id=_tokenizer.eos_token_id, pad_token_id=_tokenizer.pad_token_id
        or _tokenizer.eos_token_id,
    )
    with torch.inference_mode():
        salida = _modelo.generate(**entradas, generation_config=config_gen)
    return _tokenizer.decode(salida[0, entradas["input_ids"].shape[1]:], skip_special_tokens=True)


def generar_sql(esquema: str, pregunta: str, ejecutar=None) -> str:
    inicio = time.monotonic()

    def restante():
        return TIEMPO_MAX_PREGUNTA - MARGEN_SEGURIDAD - (time.monotonic() - inicio)

    mensajes = construir_mensajes(esquema, pregunta)
    try:
        crudo = _generar(mensajes, restante())
    except Exception:
        return CONSULTA_SEGURA
    sql = extraer_sql(crudo)
    mejor = sql if es_solo_lectura(sql) else CONSULTA_SEGURA
    if ejecutar is None:
        return mejor

    # Autocorrección: se ejecuta y, si MySQL da error, se le pide al modelo que corrija.
    for llamada in range(MAX_LLAMADAS_EJECUTAR):
        if not es_solo_lectura(sql):
            break
        try:
            resultado = ejecutar(sql) or {}
        except Exception:
            break
        if resultado.get("ok"):
            return sql
        # quedan llamadas y tiempo para una corrección (~8 s en T4)?
        if llamada == MAX_LLAMADAS_EJECUTAR - 1 or restante() < 8:
            break
        mensajes = mensajes + [
            {"role": "assistant", "content": sql},
            {"role": "user", "content": PLANTILLA_CORRECCION.format(
                error=str(resultado.get("error", ""))[:500])},
        ]
        try:
            corregida = extraer_sql(_generar(mensajes, restante()))
        except Exception:
            break
        if es_solo_lectura(corregida):
            sql = corregida
            mejor = corregida
    return mejor


if os.environ.get("T2S_NO_CARGAR_MODELO") != "1":
    _cargar()
