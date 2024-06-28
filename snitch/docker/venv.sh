#!/usr/bin/env bash

set -euo pipefail

VENV_DIR=/src/.venv-docker
FORCE_VENV=0

if [[ -d /src/xdsl ]]; then
  pushd /src/xdsl > /dev/null
  if [[ 1 -eq ${FORCE_VENV} ]] || [[ ! -d ${VENV_DIR} ]] || [[ ! -f ${VENV_DIR}/bin/activate ]]; then
    python3 -m venv ${VENV_DIR}
    source ${VENV_DIR}/bin/activate
    pip install --upgrade pip
    pip install -r /src/scripts/requirements.txt
  else
    source ${VENV_DIR}/bin/activate
  fi
  popd
fi

