#!/usr/bin/env bash
# Instala y arranca MySQL 8.4.10 en Colab (sin Docker), con la configuración por defecto,
# en el puerto 3307 y con root/root, igual que docker-compose.yml.
# Uso: bash scripts/evaluacion/instalar_mysql_colab.sh
set -euo pipefail

DIR=/content/mysql
DATOS=/content/mysql_datos
URL=https://downloads.mysql.com/archives/get/p/23/file/mysql-8.4.10-linux-glibc2.17-x86_64-minimal.tar.xz

if [ ! -x "$DIR/bin/mysqld" ]; then
  apt-get -qq update >/dev/null
  apt-get -qq install -y libaio1 libnuma1 >/dev/null 2>&1 || apt-get -qq install -y libaio1t64 libnuma1 >/dev/null
  # Ubuntu 24.04 renombró libaio.so.1 a libaio.so.1t64
  if [ ! -e /usr/lib/x86_64-linux-gnu/libaio.so.1 ] && [ -e /usr/lib/x86_64-linux-gnu/libaio.so.1t64 ]; then
    ln -s /usr/lib/x86_64-linux-gnu/libaio.so.1t64 /usr/lib/x86_64-linux-gnu/libaio.so.1
  fi
  wget -q "$URL" -O /tmp/mysql.tar.xz
  mkdir -p "$DIR"
  tar -xf /tmp/mysql.tar.xz -C "$DIR" --strip-components=1
fi

if [ ! -d "$DATOS/mysql" ]; then
  "$DIR/bin/mysqld" --initialize-insecure --user=root --datadir="$DATOS" --basedir="$DIR"
fi

if ! pgrep -x mysqld >/dev/null; then
  nohup "$DIR/bin/mysqld" --user=root --basedir="$DIR" --datadir="$DATOS" --port=3307 \
    --bind-address=127.0.0.1 --socket=/tmp/mysql.sock --mysqlx=OFF \
    > /content/mysqld.log 2>&1 &
fi

python - <<'EOF'
import time
import pymysql
for _ in range(60):
    try:
        conn = pymysql.connect(unix_socket="/tmp/mysql.sock", user="root", password="")
        break
    except pymysql.err.OperationalError as e:
        if e.args[0] == 1045:   # ya tenía contraseña: instalación previa
            conn = pymysql.connect(unix_socket="/tmp/mysql.sock", user="root", password="root")
            break
        time.sleep(1)
else:
    raise SystemExit("MySQL no arrancó; ver /content/mysqld.log")
with conn.cursor() as cur:
    cur.execute("ALTER USER 'root'@'localhost' IDENTIFIED BY 'root'")
    cur.execute("CREATE USER IF NOT EXISTS 'root'@'127.0.0.1' IDENTIFIED BY 'root'")
    cur.execute("GRANT ALL ON *.* TO 'root'@'127.0.0.1' WITH GRANT OPTION")
    cur.execute("SELECT VERSION()")
    print("MySQL", cur.fetchone()[0], "listo en el puerto 3307")
EOF
