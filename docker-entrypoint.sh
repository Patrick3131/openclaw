#!/usr/bin/env bash
set -euo pipefail

STATE_DIR="${OPENCLAW_STATE_DIR:-${HOME}/.openclaw}"
CONFIG_PATH="${OPENCLAW_CONFIG_PATH:-${STATE_DIR}/openclaw.json}"

mkdir -p "$STATE_DIR"

if [[ "$(id -u)" == "0" ]]; then
  chown -R node:node "$STATE_DIR"
fi

if [[ ! -f "$CONFIG_PATH" ]]; then
  node dist/index.js config set gateway.mode local
fi

if [[ "$(id -u)" == "0" ]]; then
  exec runuser -u node -- "$@"
fi

exec "$@"
