"""Utilidades compartidas por los scripts de datos y evaluación.

Conexión a MySQL 8.4.10 (docker-compose.yml, puerto 3307) y ejecución de
consultas con clasificación del error, para poder reportar descartes.
"""
import os
import re

import pymysql

MYSQL = dict(
    host=os.environ.get("MYSQL_HOST", "127.0.0.1"),
    port=int(os.environ.get("MYSQL_PORT", "3307")),
    user=os.environ.get("MYSQL_USER", "root"),
    password=os.environ.get("MYSQL_PASSWORD", "root"),
    charset="utf8mb4",
    autocommit=True,
)

# errno de MySQL -> categoría legible para el reporte de descartes
CATEGORIAS_ERROR = {
    1055: "only_full_group_by",
    1054: "columna_inexistente",
    1146: "tabla_inexistente",
    1064: "sintaxis",
    1052: "columna_ambigua",
    1248: "derivada_sin_alias",
    1241: "operando_columnas",
    1242: "subconsulta_varias_filas",
    3024: "timeout",
    1235: "no_soportado_mysql",
    1221: "uso_incorrecto_union_order",
    1111: "uso_invalido_agregacion",
    1140: "mezcla_agregado_sin_group_by",
    3065: "order_by_fuera_de_distinct",
    1525: "valor_incorrecto",
}


def conectar(db=None):
    return pymysql.connect(database=db, **MYSQL)


def ejecutar(conn, sql, max_filas=None, timeout_ms=10000):
    """Ejecuta `sql` y devuelve dict(ok, columnas, filas, error, categoria)."""
    try:
        with conn.cursor() as cur:
            cur.execute(f"SET SESSION MAX_EXECUTION_TIME={int(timeout_ms)}")
            cur.execute(sql)
            columnas = [d[0] for d in cur.description] if cur.description else []
            filas = cur.fetchall() if max_filas is None else cur.fetchmany(max_filas)
            return dict(ok=True, columnas=columnas, filas=[list(f) for f in filas],
                        error=None, categoria=None)
    except pymysql.MySQLError as e:
        errno = e.args[0] if e.args and isinstance(e.args[0], int) else -1
        msg = e.args[1] if len(e.args) > 1 else str(e)
        return dict(ok=False, columnas=[], filas=[], error=f"({errno}) {msg}",
                    categoria=CATEGORIAS_ERROR.get(errno, f"mysql_{errno}"))


_PALABRAS_PROHIBIDAS = re.compile(
    r"\b(INSERT|UPDATE|DELETE|DROP|ALTER|CREATE|TRUNCATE|RENAME|GRANT|REVOKE|"
    r"LOCK|CALL|LOAD|INTO|OUTFILE|DUMPFILE)\b",
    re.IGNORECASE,
)


def es_solo_lectura(sql):
    """True si `sql` es una sola sentencia SELECT o WITH ... SELECT."""
    sin_literales = re.sub(r"'(?:[^'\\]|\\.|'')*'", "''", sql)
    sin_literales = re.sub(r'"(?:[^"\\]|\\.)*"', '""', sin_literales)
    sin_literales = re.sub(r"`[^`]*`", "``", sin_literales)
    cuerpo = sin_literales.strip().rstrip(";").strip()
    if ";" in cuerpo:
        return False
    if not re.match(r"^\(?\s*(SELECT|WITH)\b", cuerpo, re.IGNORECASE):
        return False
    return not _PALABRAS_PROHIBIDAS.search(cuerpo)


def esquema_de_base(conn, db):
    """Esquema como lo entrega el evaluador: SHOW CREATE TABLE de cada tabla."""
    with conn.cursor() as cur:
        cur.execute(f"SHOW FULL TABLES FROM `{db}` WHERE Table_type = 'BASE TABLE'")
        tablas = [r[0] for r in cur.fetchall()]
        partes = []
        for t in tablas:
            cur.execute(f"SHOW CREATE TABLE `{db}`.`{t}`")
            partes.append(cur.fetchone()[1] + ";")
    return "\n\n".join(partes)
