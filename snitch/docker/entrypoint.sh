#!/usr/bin/env bash

set -euo pipefail

SETUP=/src/snitch/docker/venv.sh

if [ -f "${SETUP}" ]; then
  source "${SETUP}"
else
  >&2 echo "WARNING: can't find source repo mounted at /src, brace for bad things"
fi

exec "$@"
