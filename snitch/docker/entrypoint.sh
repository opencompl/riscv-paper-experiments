#!/bin/bash

VALID_ARGS=$(getopt -o f,h --long force,help -- "$@")
if [[ $? -ne 0 ]]; then
  exit 1;
fi

VENV_DIR=venv_docker
FORCE=0

eval set -- "$VALID_ARGS"
while [ : ]; do
  case "$1" in
    -f | --force)
      FORCE=1
      echo "Forcing venv installation"
      shift
      ;;
    -h | --help)
      echo ""
      echo "-f | --force   Force venv installation."
      echo "-h | --help    This help message."
      shift
      exit 0
      ;;
    --) shift;
      break
      ;;
  esac
done

pushd /src/xdsl > /dev/null

if [[ 1 -eq ${FORCE} ]] || [[ ! -d ${VENV_DIR} ]] || [[ ! -f ${VENV_DIR}/bin/activate ]]; then
  python3 -m venv ${VENV_DIR}
  source ${VENV_DIR}/bin/activate

  pip install -e .
  pip install pandas
else
  source ${VENV_DIR}/bin/activate
fi

exec "$@"

popd
