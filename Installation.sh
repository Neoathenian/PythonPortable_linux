#!/usr/bin/env bash
set -euo pipefail

PY_VERSION="${PY_VERSION:-3.11}"
ROOT_DIR="$(cd -- "$(dirname "$0")" >/dev/null 2>&1 && pwd)"
PP_DIR="$ROOT_DIR/PythonPortable"
MM_BIN="$PP_DIR/bin/micromamba"
ENV_PREFIX="$PP_DIR/env"
REQ_FILE="${REQ_FILE:-$ROOT_DIR/requirements.txt}"

mkdir -p "$PP_DIR/bin"

echo "Downloading micromamba…"
# Static micromamba, no root needed
curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest \
 | tar -xvj -C "$PP_DIR/bin" --strip-components=1 bin/micromamba

echo "Creating portable env at $ENV_PREFIX…"
"$MM_BIN" create -y -p "$ENV_PREFIX" python="$PY_VERSION" pip tk setuptools wheel

if [[ -f "$REQ_FILE" ]]; then
  echo "Installing requirements from $REQ_FILE…"
  "$MM_BIN" run -p "$ENV_PREFIX" python -m pip install -r "$REQ_FILE"
fi

echo "Verifying Tkinter…"
"$MM_BIN" run -p "$ENV_PREFIX" python - <<'PY'
import sys
try:
    import tkinter as tk
    print("Tkinter OK", tk.TkVersion)
except Exception as e:
    print("Tkinter import failed:", e, file=sys.stderr); sys.exit(1)
PY

echo "Done."
echo "Run your app with ./Run.sh"
