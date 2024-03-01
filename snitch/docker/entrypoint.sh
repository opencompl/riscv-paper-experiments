#!/bin/bash

VENV_DIR=venv_docker
FORCE_VENV=0

pushd /src/xdsl > /dev/null

if [[ 1 -eq ${FORCE_VENV} ]] || [[ ! -d ${VENV_DIR} ]] || [[ ! -f ${VENV_DIR}/bin/activate ]]; then
  python3 -m venv ${VENV_DIR}
  source ${VENV_DIR}/bin/activate

  pip install -e .
  pip install pandas
else
  source ${VENV_DIR}/bin/activate
fi

popd

exec "$@"
