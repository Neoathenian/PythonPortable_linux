#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(cd -- "$(dirname "$0")" >/dev/null 2>&1 && pwd)"
ENV_PREFIX="$ROOT_DIR/PythonPortable/env"
MM_BIN="$ROOT_DIR/PythonPortable/bin/micromamba"

# Edit the next line or pass packages as args: ./Install_additional_modules.sh numpy pandas
PKGS=("pandas";"seaborn")

if [[ ${#PKGS[@]} -eq 0 ]]; then
  echo "Usage: $0 <pkg1> <pkg2> …   (or edit this script)"; exit 1
fi

"$MM_BIN" run -p "$ENV_PREFIX" python -m pip install "${PKGS[@]}"
