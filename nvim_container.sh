#!/bin/bash

WORKING_DIRECTORY="."
SCRIPT_DIR_PATH="$(dirname "$0")"
source "${SCRIPT_DIR_PATH}/paths.sh"

function print_usage() {
    echo "<PROG_PATH> <VENV_DOCKER_IMAGE_NAME>"
}

if [[ $1 == "" ]]; then
    print_usage
    exit 1
fi
VENV_DOCKER_IMAGE_NAME=$1

PROJECT_VIRTAUL_ENV_PATH="${VIRTUAL_ENV_DIR_PATH}/${VENV_DOCKER_IMAGE_NAME/\:/__}"

ACTIVATE_VENV_FILE_PATH=${PROJECT_VIRTAUL_ENV_PATH}/bin/activate

if [[ ! -f ${ACTIVATE_VENV_FILE_PATH} ]]; then
    echo "venv isn't installed. please run './download_venv_from_docker_image.sh'"
    echo "${ACTIVATE_VENV_FILE_PATH} doesn't exist..."
    exit 1
fi

echo Using ${ACTIVATE_VENV_FILE_PATH}
source ${ACTIVATE_VENV_FILE_PATH}

which python
which python3
which pip
which pip3

touch ${WORKING_DIRECTORY}/.vimrc

VIM_CONFIG_PATH=${VIM_CONFIG_DIR_PATH} nvim -u ${VIM_CONFIG_DIR_PATH}/.vimrc ${@:2}
