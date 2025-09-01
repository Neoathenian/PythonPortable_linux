#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd -- "$(dirname "$0")" >/dev/null 2>&1 && pwd)"
ENV_PREFIX="$ROOT_DIR/PythonPortable/env"
MM_BIN="$ROOT_DIR/PythonPortable/bin/micromamba"

# Set this to your entrypoint file name (just the file name if it lives here)
SCRIPT_NAME="main.py"

exec "$MM_BIN" run -p "$ENV_PREFIX" python "$ROOT_DIR/$SCRIPT_NAME" "$@"
