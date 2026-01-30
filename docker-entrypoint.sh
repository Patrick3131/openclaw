#!/usr/bin/env bash
set -euo pipefail

CONFIG_PATH="${OPENCLAW_CONFIG_PATH:-${HOME}/.openclaw/openclaw.json}"

if [[ ! -f "$CONFIG_PATH" ]]; then
  node dist/index.js config set gateway.mode local
fi

exec "$@"
