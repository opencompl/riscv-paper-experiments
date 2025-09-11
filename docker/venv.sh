#!/usr/bin/env bash

set -euo pipefail

VENV_DIR=/src/.venv-docker
FORCE_VENV=0

if [[ -d /src/xdsl ]]; then
  pushd /src/xdsl > /dev/null
  if [[ 1 -eq ${FORCE_VENV} ]] || [[ ! -d ${VENV_DIR} ]] || [[ ! -f ${VENV_DIR}/bin/activate ]]; then
    uv venv -p 3.11 ${VENV_DIR}
    source ${VENV_DIR}/bin/activate
    uv pip install -r /src/requirements.txt
    uv pip install /opt/snitch_cluster/
  else
    source ${VENV_DIR}/bin/activate
  fi
  popd
fi

