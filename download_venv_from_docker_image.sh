#!/bin/bash

SCRIPT_DIR_PATH="$(dirname "$0")"
source "${SCRIPT_DIR_PATH}/paths.sh"

function print_usage() {
    echo "<PROG_PATH> <DOKCER_IMAGE_NAME> <VENV_PATH_INSIDE_CONTAINER>"
}

if [[ $1 == "" ]]; then
    print_usage
    exit -1
fi
DOCKER_IMAGE_NAME=$1

if [[ $2 == "" ]]; then
    print_usage
    exit -1
fi
VENV_PATH_INSIDE_CONTAINER=$2

if [[ $(( $(docker images -q ${DOCKER_IMAGE_NAME} | wc -l) )) != 1 ]]; 
then 
    echo Please check image name exists and only once.
    exit -1
fi

DEST_VENV_DIR_PATH="${VIRTUAL_ENV_DIR_PATH}/${DOCKER_IMAGE_NAME/\:/__}"
if [[ -d ${DEST_VENV_DIR_PATH} ]]; 
then 
    echo ${DEST_VENV_DIR_PATH} already exist. delete it first
    exit -1
fi

mkdir -p ${DEST_VENV_DIR_PATH}

temp_container_id=$(docker create ${DOCKER_IMAGE_NAME})
docker cp ${temp_container_id}:${VENV_PATH_INSIDE_CONTAINER}/. ${DEST_VENV_DIR_PATH}
docker rm -v ${temp_container_id}

if [[ ! -f ${DEST_VENV_DIR_PATH}/bin/activate ]]; 
then 
    echo Failed to create download venv...
    exit -1
fi
