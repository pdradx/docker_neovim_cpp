#!/usr/bin/env bash
set -euo pipefail # Exit on error (-e) and print each command (-x) for debugging

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/config.sh"

docker start $CONTAINER_NAME
