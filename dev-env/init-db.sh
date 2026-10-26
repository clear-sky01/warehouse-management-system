#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SQL_FILE="$ROOT_DIR/Server/frame/src/main/resources/数据库脚本/crush.sql"

MYSQL_HOST="${MYSQL_HOST:-127.0.0.1}"
MYSQL_PORT="${MYSQL_PORT:-3306}"
MYSQL_USER="${MYSQL_USER:-root}"
MYSQL_PASSWORD="${MYSQL_PASSWORD:-}"
MYSQL_DATABASE="${MYSQL_DATABASE:-crush}"

MYSQL_ARGS=(-h"$MYSQL_HOST" -P"$MYSQL_PORT" -u"$MYSQL_USER")
if [[ -n "$MYSQL_PASSWORD" ]]; then
  MYSQL_ARGS+=(-p"$MYSQL_PASSWORD")
fi

mysql "${MYSQL_ARGS[@]}" -e "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
mysql "${MYSQL_ARGS[@]}" "$MYSQL_DATABASE" < "$SQL_FILE"

echo "Database '$MYSQL_DATABASE' initialized from $SQL_FILE"
