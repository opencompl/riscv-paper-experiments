#!/usr/bin/env bash

set -euo pipefail

VENV_DIR=/src/.venv-docker
FORCE_VENV=0

if [[ ! -d ${VENV_DIR} ]]; then
  uv venv ${VENV_DIR}
  source ${VENV_DIR}/bin/activate
  uv pip install -r /src/requirements.txt
else
  source ${VENV_DIR}/bin/activate
fi
