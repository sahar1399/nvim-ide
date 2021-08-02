#!/bin/bash

ROOT_PATH=$(pwd)
IDE_PATH=${ROOT_PATH}

source ${IDE_PATH}/vars.sh

function print_usage() {
    echo "USAGE: <PROG_PATH> <BASE_IMAGE> cmd..."
}

if [[ $1 == "" ]]; then
    print_usage
    exit 1
fi
BASE_IMAGE=$1

mkdir -p ${DEBUG_LOG_PATH}

RANGER_PORT=5000

docker run                                              \
    -it                                                 \
    --rm                                                \
    --privileged                                        \
                                                        \
    -p ${DEBUG_PORT}:${DEBUG_PORT}                      \
    -p ${RANGER_PORT}:${RANGER_PORT}                    \
                                                        \
    -v ${LOCAL_ROOT}:${REMOTE_ROOT}                     \
                                                        \
    -w="${REMOTE_ROOT}"                                 \
                                                        \
    ${BASE_IMAGE}-debugpy                               \
    ${REMOTE_DEBUGGER_ROOT}/debugpy_forever.sh ${@:2}
