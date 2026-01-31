#!/usr/bin/env bash
set -euo pipefail

STATE_DIR="${OPENCLAW_STATE_DIR:-${HOME}/.openclaw}"
CONFIG_PATH="${OPENCLAW_CONFIG_PATH:-${STATE_DIR}/openclaw.json}"

mkdir -p "$STATE_DIR"
chmod 700 "$STATE_DIR" || true

if [[ "$(id -u)" == "0" ]]; then
  chown -R node:node "$STATE_DIR" || true
fi

ensure_node_access() {
  if [[ "$(id -u)" != "0" ]]; then
    return 0
  fi
  if runuser -u node -- test -w "$STATE_DIR"; then
    return 0
  fi
  # Fallback for volumes that disallow chown (e.g. root-squash mounts).
  chmod -R a+rwX "$STATE_DIR" || true
}

if [[ ! -f "$CONFIG_PATH" ]]; then
  if [[ "$(id -u)" == "0" ]]; then
    runuser -u node -- node dist/index.js config set gateway.mode local
  else
    node dist/index.js config set gateway.mode local
  fi
fi

if [[ "$(id -u)" == "0" ]]; then
  chown -R node:node "$STATE_DIR" || true
  ensure_node_access
  exec runuser -u node -- "$@"
fi

exec "$@"
