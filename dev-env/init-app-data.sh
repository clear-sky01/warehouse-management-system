#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${BASE_URL:-http://127.0.0.1:8888}"

echo "GET $BASE_URL/init/all"
curl -fsS "$BASE_URL/init/all"
echo

echo "Application seed data initialized."
