#!/usr/bin/env bash
set -euo pipefail

STATE_DIR="${OPENCLAW_STATE_DIR:-${HOME}/.openclaw}"
CONFIG_PATH="${OPENCLAW_CONFIG_PATH:-${STATE_DIR}/openclaw.json}"

mkdir -p "$STATE_DIR"
chmod 700 "$STATE_DIR" || true

if [[ "$(id -u)" == "0" ]]; then
  chown -R node:node "$STATE_DIR" || true
fi

if [[ ! -f "$CONFIG_PATH" ]]; then
  if [[ "$(id -u)" == "0" ]]; then
    runuser -u node -- node dist/index.js config set gateway.mode local
  else
    node dist/index.js config set gateway.mode local
  fi
fi

if [[ "$(id -u)" == "0" ]]; then
  chown -R node:node "$STATE_DIR" || true
  exec runuser -u node -- "$@"
fi

exec "$@"
