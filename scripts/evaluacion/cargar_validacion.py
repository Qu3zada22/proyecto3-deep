"""Carga los esquemas de validación en MySQL 8.4.10 y crea el usuario de solo lectura.

Cada esquema vive en datos/validacion/<nombre>/ con esquema.sql y datos.sql y se carga
en la base `val_<nombre>`. El usuario `lector` (contraseña `lector`) solo tiene SELECT
sobre esas bases: es el que usa el evaluador para `ejecutar(sql)`, como el del docente.

Uso: .venv/bin/python scripts/evaluacion/cargar_validacion.py
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from comun import conectar  # noqa: E402

RAIZ = Path(__file__).resolve().parents[2]
CARPETA = RAIZ / "datos/validacion"
PREFIJO_DB = "val_"


def ejecutar_script(conn, texto):
    """Ejecuta un archivo .sql sentencia por sentencia (separadas por ';' a fin de línea)."""
    sentencias, actual = [], []
    for linea in texto.splitlines():
        if linea.strip().startswith("--"):
            continue
        actual.append(linea)
        if linea.rstrip().endswith(";"):
            sentencias.append("\n".join(actual))
            actual = []
    if "".join(actual).strip():
        sentencias.append("\n".join(actual))
    with conn.cursor() as cur:
        for s in sentencias:
            if s.strip():
                cur.execute(s)


def main():
    conn = conectar()
    with conn.cursor() as cur:
        cur.execute("CREATE USER IF NOT EXISTS 'lector'@'%' IDENTIFIED BY 'lector'")
    for d in sorted(d for d in CARPETA.iterdir() if (d / "esquema.sql").exists()):
        db = PREFIJO_DB + d.name
        with conn.cursor() as cur:
            cur.execute(f"DROP DATABASE IF EXISTS `{db}`")
            cur.execute(f"CREATE DATABASE `{db}`")
            cur.execute(f"GRANT SELECT ON `{db}`.* TO 'lector'@'%'")
        conn.select_db(db)
        ejecutar_script(conn, (d / "esquema.sql").read_text(encoding="utf-8"))
        ejecutar_script(conn, (d / "datos.sql").read_text(encoding="utf-8"))
        with conn.cursor() as cur:
            cur.execute("SELECT table_name, table_rows FROM information_schema.tables "
                        "WHERE table_schema = %s ORDER BY table_name", (db,))
            conteo = ", ".join(f"{t} {n}" for t, n in cur.fetchall())
        print(f"{db}: {conteo}")
    print("OK: esquemas de validación cargados")


if __name__ == "__main__":
    main()
