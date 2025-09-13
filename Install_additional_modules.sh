#!/bin/sh
set -eu

ROOT_DIR="$(cd -- "$(dirname "$0")" >/dev/null 2>&1 && pwd)"
ENV_PREFIX="$ROOT_DIR/PythonPortable/env"
MM_BIN="$ROOT_DIR/PythonPortable/bin/micromamba"

# If args are given, use them; else default list
if [ "$#" -gt 0 ]; then
  PKGS="$@"
else
  PKGS="google-cloud-secret-manager google-cloud"
fi

if [ -z "$PKGS" ]; then
  echo "Usage: $0 <pkg1> <pkg2> …   (or edit this script)"
  exit 1
fi

# shellcheck disable=SC2086  # we want word splitting here
"$MM_BIN" run -p "$ENV_PREFIX" python -m pip install $PKGS
