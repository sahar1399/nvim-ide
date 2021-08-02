#!/bin/bash

ROOT_PATH=$(pwd)
IDE_PATH=${ROOT_PATH}/ide
VIM_CONFIG_PATH=${IDE_PATH}/.vim
VIRTUAL_ENV_PATH=${IDE_PATH}/venv

function print_usage() {
    echo "<PROG_PATH> <PROJECT_NAME>"
}

if [[ $1 == "" ]]; then
    print_usage
    exit 1
fi
PROJECT_NAME=$1

PROJECT_PATH="${ROOT_PATH}/${PROJECT_NAME}"
PROJECT_VIRTAUL_ENV_PATH="${VIRTUAL_ENV_PATH}/${PROJECT_NAME}"

ACTIVATE_VENV_FILE_PATH=${PROJECT_VIRTAUL_ENV_PATH}/bin/activate

if [[ ! -f ${ACTIVATE_VENV_FILE_PATH} ]]; then
    echo "venv isn't installed. please run './prepare_venv.sh ${PROJECT_NAME}'"
    echo "${ACTIVATE_VENV_FILE_PATH} doesn't exist..."
    exit 1
fi

echo Using ${ACTIVATE_VENV_FILE_PATH}
source ${ACTIVATE_VENV_FILE_PATH}

which python
which pip

which python3
which pip3

VIM_CONFIG_PATH=${VIM_CONFIG_PATH} nvim -u ${VIM_CONFIG_PATH}/.vimrc ${@:2}
