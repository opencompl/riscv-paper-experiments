#!/usr/bin/env bash

VALID_ARGS=$(getopt -o h --long tag:,abort-on-error,skip-clean,skip-build,skip-run,skip-results,help -- "$@")
if [[ $? -ne 0 ]]; then
    exit 1;
fi

TAG=$(date +"%FT%H%M%S")
ABORT_ON_ERROR=0
SKIP_CLEAN=0
SKIP_BUILD=0
SKIP_RUN=0
SKIP_RESULTS=0

eval set -- "$VALID_ARGS"
while [ : ]; do
  case "$1" in
    --tag)
        case "$2" in
          '')
            ;;
          *)
            TAG=$2
            ;;
        esac
        shift 2
        ;;
    --abort-on-error)
        ABORT_ON_ERROR=1
        shift
        ;;
    --skip-clean)
        SKIP_CLEAN=1
        shift
        ;;
    --skip-build)
        SKIP_BUILD=1
        shift
        ;;
    --skip-run)
        echo "Skip the run step"
        SKIP_RUN=1
        shift
        ;;
    --skip-results)
        SKIP_RESULTS=1
        echo "Skip the results step"
        shift
        ;;
    -h | --help)
        echo ""
        echo "--tag [NAME]      Provide custom tag for results files."
        echo "--abort-on-error  Abort upon the first error that occurs."
        echo "--skip-clean      Skip the clean step of build directories."
        echo "--skip-build      Skip the build step."
        echo "--skip-run        Skip the run step."
        echo "--skip-results    Skip the results step."
        echo "-h | --help       This help message."
        shift
        exit 0
        ;;
    --) shift;
        break
        ;;
  esac
done

# detect if we are within Docker instance
[ -f /.dockerenv ] && export PATH=/opt/python3.11/bin/:$PATH

THIS_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

XDSL_DIR=${THIS_DIR}/../xdsl/
SCRIPTS_DIR=${THIS_DIR}/../scripts/
PLOTTING_DIR=${THIS_DIR}/../scripts/plotting/
KERNEL_ROOT=${THIS_DIR}/../kernels/

RESULTS_DIR=${THIS_DIR}/../results/

VENV_DIR=".venv"

KERNEL_DIRS=(
  # "saxpy/64xf32/"
  # "ssum/8x16xf32/"
  # "ssum/14x26xf32/"
  "dsum/8x16xf32/"
  #"matmul/16x16xf64/"
  "relu/16x16xf64/"
)

if [[ 1 -eq ${ABORT_ON_ERROR} ]]; then
  set -e
fi

# Clean step

if [[ 0 -eq ${SKIP_CLEAN} ]]; then
  make VENV_DIR=${VENV_DIR} -C ${XDSL_DIR} clean
  rm -rf ${SCRIPTS_DIR}/${VENV_DIR}

  for krnl in ${KERNEL_DIRS[@]}; do
    make -C ${KERNEL_ROOT}/${krnl} -j $(nproc) clean
  done
fi

# Setup/build step

if [[ 0 -eq ${SKIP_BUILD} ]]; then
  mkdir -p ${RESULTS_DIR}

  python3 -m venv ${SCRIPTS_DIR}/${VENV_DIR}
  . ${SCRIPTS_DIR}/${VENV_DIR}/bin/activate
  pip install -r ${SCRIPTS_DIR}/requirements.txt
  deactivate

  make VENV_DIR=${VENV_DIR} -C ${XDSL_DIR} venv

  . ${XDSL_DIR}/${VENV_DIR}/bin/activate

  [ ! -x $(which xdsl-opt) ] && echo "xdsl-opt is not found in PATH" && exit 1

  for krnl in ${KERNEL_DIRS[@]}; do
    make -C ${KERNEL_ROOT}/${krnl} -j $(nproc) all
  done
fi

# Run step

if [[ 0 -eq ${SKIP_RUN} ]]; then
  for krnl in ${KERNEL_DIRS[@]}; do
    make -C ${KERNEL_ROOT}/${krnl} -j $(nproc) allrun
    make -C ${KERNEL_ROOT}/${krnl} traces
  done
fi

# Results step

if [[ 0 -eq ${SKIP_RESULTS} ]]; then
  . ${SCRIPTS_DIR}/${VENV_DIR}/bin/activate

  CYCLES_CSV="${RESULTS_DIR}/cycles_${TAG}.csv"

  ${SCRIPTS_DIR}/harvest_results.py -s ${KERNEL_ROOT} \
    -e cycles \
    -f kernel size version cycles \
    -o ${CYCLES_CSV}

  ${PLOTTING_DIR}/plot_barchart.py -f ${CYCLES_CSV} \
    -s ${PLOTTING_DIR}/config/cycles/barchart.mplstyle \
    -c ${PLOTTING_DIR}/config/cycles/barchart.json
fi
