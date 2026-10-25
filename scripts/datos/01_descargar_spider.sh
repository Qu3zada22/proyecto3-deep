#!/usr/bin/env bash
# Descarga Spider 1.0 (bases SQLite + splits) y verifica el checksum.
# Fuente: re-host en Hugging Face del zip oficial de Yale (CC BY-SA 4.0).
set -euo pipefail
DEST="datos/crudo"
URL="https://huggingface.co/datasets/HAL-9001/spider-databases/resolve/main/spider_data.zip"
SHA="00636695dabed6b5f4b8328a16b13e069a2f16591d5efcce57660669c85b121b"
mkdir -p "$DEST"
curl -L -o "$DEST/spider_data.zip" "$URL"
echo "$SHA  $DEST/spider_data.zip" | shasum -a 256 -c -
unzip -q -o "$DEST/spider_data.zip" -d "$DEST"
# el split de test no se usa: se borra para ahorrar ~900 MB
rm -rf "$DEST/spider_data.zip" "$DEST/spider_data/test_database" "$DEST"/spider_data/test*.json "$DEST/spider_data/test_gold.sql"
echo "Listo: $DEST/spider_data"
