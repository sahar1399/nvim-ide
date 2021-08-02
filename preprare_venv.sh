#!/bin/bash

function print_usage() {
    echo "<PROG_PATH> <VENV_NAME_PATH>"
}

if [[ $1 == "" ]]; then
    print_usage
    exit -1
fi
PROJECT_PATH=$1

PROJECT_PATH="${ROOT_PATH}/${PROJECT_PATH}"
PROJECT_VIRTAUL_ENV_PATH="${VIRTUAL_ENV_PATH}/${PROJECT_PATH}"

case $PROJECT_PATH in
    ranger)
    REQUIREMENTS_FILE_NAME="requirements.txt"
;;
*)
    echo "project name isn't supported. add support to switch case."
    exit 1
esac

# Commands:

mkdir -p ${VIRTUAL_ENV_PATH}

ACTIVATE_VENV_FILE_PATH=${PROJECT_VIRTAUL_ENV_PATH}/bin/activate

if [[ ! -f ${ACTIVATE_VENV_FILE_PATH} ]]; then
    virtualenv ${PROJECT_VIRTAUL_ENV_PATH} 
else
    echo "venv aleady created. continuing."
fi

if [[ ! -f ${ACTIVATE_VENV_FILE_PATH} ]]; then
    echo "venv created. please fix './prepare_venv.sh ${PROJECT_PATH}'"
    echo "${ACTIVATE_VENV_FILE_PATH} doesn't exist..."
    exit 1
fi

source ${ACTIVATE_VENV_FILE_PATH}

echo *********************
which python
which pip

which python3
which pip3
echo *********************

echo running ${VIM_CONFIG_PATH}/requirements.txt
pip3 install -r ${VIM_CONFIG_PATH}/requirements.txt

echo setup liblkpo
cd ${ROOT_PATH}/liblkpo && python3 setup.py install

echo running ${VPROJECT_PATH}/${REQUIREMENTS_FILE_NAME}
cd ${PROJECT_PATH} && pip3 install -r ${REQUIREMENTS_FILE_NAME} || true

echo "created ${ACTIVATE_VENV_FILE_PATH}"
