#!/usr/bin/env bash

set -euo pipefail

VENV_DIR=/src/.venv-docker
FORCE_VENV=0


if [[ "${FORCE_VENV}" == "1" ]] || [[ ! -d "${VENV_DIR}" ]] || [[ ! -f "${VENV_DIR}/bin/activate" ]]; then
  python3 -m venv "${VENV_DIR}"
  # shellcheck disable=SC1090
  source "${VENV_DIR}/bin/activate"
  pip install --upgrade pip
  pip install -r /src/requirements.txt
else
  # shellcheck disable=SC1090
  source "${VENV_DIR}/bin/activate"
fi

