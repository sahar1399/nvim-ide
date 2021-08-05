#!/bin/bash

SCRIPT_DIR_PATH="$(dirname "$0")"
source "${SCRIPT_DIR_PATH}/paths.sh"

VIM_CONFIG_PATH=${VIM_CONFIG_DIR_PATH} nvim -u ${VIM_CONFIG_DIR_PATH}/.vimrc ${@:2}
