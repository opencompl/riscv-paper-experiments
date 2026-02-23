#!/usr/bin/env bash

set -euo pipefail

# Sync project deps into /opt/venv (set via UV_PROJECT_ENVIRONMENT in the
# Dockerfile). --inexact avoids removing the snitch package, which is
# installed separately and not listed in our pyproject.toml.
if [ -f /src/pyproject.toml ]; then
  uv sync --directory /src --inexact
fi

exec "$@"
