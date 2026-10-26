#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PID_DIR="$ROOT_DIR/dev-env/pids"

stop_by_pid_file() {
  local name="$1"
  local pid_file="$2"

  if [[ ! -f "$pid_file" ]]; then
    echo "$name is not running."
    return 0
  fi

  local pid
  pid="$(cat "$pid_file")"
  if kill -0 "$pid" >/dev/null 2>&1; then
    kill "$pid"
    echo "Stopped $name with PID $pid."
  else
    echo "$name PID file exists, but process is not running."
  fi
  rm -f "$pid_file"
}

stop_by_pid_file "frontend" "$PID_DIR/frontend.pid"
stop_by_pid_file "backend" "$PID_DIR/backend.pid"
