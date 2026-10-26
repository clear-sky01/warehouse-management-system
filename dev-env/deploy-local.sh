#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOG_DIR="$ROOT_DIR/dev-env/logs"
PID_DIR="$ROOT_DIR/dev-env/pids"

mkdir -p "$LOG_DIR" "$PID_DIR"

wait_for_url() {
  local url="$1"
  local name="$2"
  local retries="${3:-60}"

  for ((i = 1; i <= retries; i++)); do
    if curl -fsS "$url" >/dev/null 2>&1; then
      echo "$name is ready: $url"
      return 0
    fi
    sleep 2
  done

  echo "$name did not become ready: $url" >&2
  return 1
}

ensure_command() {
  local command_name="$1"
  if ! command -v "$command_name" >/dev/null 2>&1; then
    echo "Missing command: $command_name" >&2
    exit 1
  fi
}

start_brew_service_if_needed() {
  local service="$1"
  if command -v brew >/dev/null 2>&1; then
    brew services start "$service" >/dev/null 2>&1 || true
  fi
}

echo "Checking local dependencies..."
ensure_command java
ensure_command mvn
ensure_command mysql
ensure_command npm
ensure_command curl

start_brew_service_if_needed mysql
start_brew_service_if_needed redis

echo "Initializing database..."
"$ROOT_DIR/dev-env/init-db.sh"

echo "Starting backend..."
if [[ -f "$PID_DIR/backend.pid" ]] && kill -0 "$(cat "$PID_DIR/backend.pid")" >/dev/null 2>&1; then
  echo "Backend is already running with PID $(cat "$PID_DIR/backend.pid")"
else
  nohup "$ROOT_DIR/dev-env/start-backend.sh" >"$LOG_DIR/backend.log" 2>&1 &
  echo $! >"$PID_DIR/backend.pid"
fi

wait_for_url "http://127.0.0.1:8888/swagger-ui.html" "Backend"

echo "Initializing application seed data..."
"$ROOT_DIR/dev-env/init-app-data.sh" >/dev/null

echo "Installing frontend dependencies if needed..."
cd "$ROOT_DIR/Web/frame"
if [[ ! -d node_modules ]]; then
  npm install --legacy-peer-deps --package-lock=false --registry=https://registry.npmjs.org
fi

echo "Starting frontend..."
if [[ -f "$PID_DIR/frontend.pid" ]] && kill -0 "$(cat "$PID_DIR/frontend.pid")" >/dev/null 2>&1; then
  echo "Frontend is already running with PID $(cat "$PID_DIR/frontend.pid")"
else
  nohup "$ROOT_DIR/dev-env/start-frontend.sh" >"$LOG_DIR/frontend.log" 2>&1 &
  echo $! >"$PID_DIR/frontend.pid"
fi

wait_for_url "http://127.0.0.1:8889" "Frontend"

cat <<INFO

Local deployment completed.

Frontend: http://localhost:8889
Backend Swagger: http://127.0.0.1:8888/swagger-ui.html

Default account:
  account: kmgzs0713@163.com
  password: xA123456
  system: application

Logs:
  backend: $LOG_DIR/backend.log
  frontend: $LOG_DIR/frontend.log

Stop:
  $ROOT_DIR/dev-env/stop-local.sh
INFO
