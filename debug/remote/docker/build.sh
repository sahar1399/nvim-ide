#!/bin/bash

ROOT_DIR=$(pwd)
IDE_DIR=${ROOT_DIR}/ide
REMOTE_DEBUG_DOCKER=${IDE_DIR}/remote_debug/docker

function print_usage() {
    echo "USAGE: <PROG_PATH> <BASE_IMAGE>"
}

if [[ $1 == "" ]]; then
    print_usage
    exit 1
fi
BASE_IMAGE=$1

cd ${REMOTE_DEBUG_DOCKER}

docker build                                    \
    --build-arg BASE_IMAGE=${BASE_IMAGE}        \
    --tag ${BASE_IMAGE}-debugpy                 \
    .
