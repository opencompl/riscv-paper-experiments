#!/usr/bin/env bash

set -euo pipefail

# When the repo is mounted at /src, sync deps from its pyproject.toml into the image venv
if [ -f /src/pyproject.toml ]; then
  uv sync --directory /src
fi

exec "$@"
