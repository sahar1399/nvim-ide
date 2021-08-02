#!/bin/bash

source paths.sh

function print_usage() {
    echo "<PROG_PATH> <VENV_NAME> <PROJECT_PATH>"
}

if [[ $1 == "" ]]; then
    print_usage
    exit 1
fi
VENV_NAME=$1

if [[ $2 == "" ]]; then
    print_usage
    exit 1
fi
PROJECT_PATH=$2

PROJECT_VIRTAUL_ENV_PATH="${VIRTUAL_ENV_DIR_PATH}/${VENV_NAME}"

ACTIVATE_VENV_FILE_PATH=${PROJECT_VIRTAUL_ENV_PATH}/bin/activate

if [[ ! -f ${ACTIVATE_VENV_FILE_PATH} ]]; then
    echo "venv isn't installed. please run './prepare_venv.sh ${PROJECT_PATH}'"
    echo "${ACTIVATE_VENV_FILE_PATH} doesn't exist..."
    exit 1
fi

echo Using ${ACTIVATE_VENV_FILE_PATH}
source ${ACTIVATE_VENV_FILE_PATH}

VIM_CONFIG_PATH=${VIM_CONFIG_DIR_PATH} nvim -u ${VIM_CONFIG_DIR_PATH}/.vimrc ${PROJECT_PATH} ${@:3}
