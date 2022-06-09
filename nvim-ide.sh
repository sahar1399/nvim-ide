#!/bin/bash

WORKING_DIR="$(pwd)"

SCRIPT_DIR_PATH="$(dirname "$0")"
VIM_CONFIG_DIR_PATH=${SCRIPT_DIR_PATH}/.vim

#if [[ -f "${WORKING_DIR}/.venv/bin/activate" ]]; then
	#echo activating virtualenv
	#source "${WORKING_DIR}/.venv/bin/activate" 	
#fi

VIM_CONFIG_PATH=${VIM_CONFIG_DIR_PATH} nvim -u ${VIM_CONFIG_DIR_PATH}/.vimrc ${@:2}
