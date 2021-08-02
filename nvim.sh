#!/bin/bash

SCRIPT_DIR_PATH="$(dirname "$0")"
source "${SCRIPT_DIR_PATH}/paths.sh"

function print_usage() {
    echo "<PROG_PATH> <PROJECT_PATH>"
}

if [[ $1 == "" ]]; then
    print_usage
    exit 1
fi
PROJECT_PATH=$1

VIM_CONFIG_PATH=${VIM_CONFIG_DIR_PATH} nvim -u ${VIM_CONFIG_DIR_PATH}/.vimrc ${PROJECT_PATH} ${@:3}
