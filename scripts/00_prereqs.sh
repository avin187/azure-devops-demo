#!/usr/bin/env bash
set -euo pipefail
need(){ command -v "$1" >/dev/null || { echo "Missing $1"; exit 1; }; }
need az; need terraform; need kubectl; need helm; need docker; need jq
echo "✔️ All prerequisites present."
