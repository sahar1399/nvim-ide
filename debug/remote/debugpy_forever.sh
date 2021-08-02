#!/bin/bash

source /opt/ide/vars.sh

mkdir -p "${REMOTE_DEBUGGER_LOG_PATH}"

while [[ true ]]; do
    echo "**********************************************"
    #python3 -m debugpy --log-to "${DEBUGGER_REMOTE_LOG_PATH}" --configure-subProcess True --listen "0.0.0.0:${DEBUG_PORT}" $@
    python3 -m debugpy --log-to "${DEBUGGER_REMOTE_LOG_PATH}" --configure-subProcess True --wait-for-client --listen "0.0.0.0:${DEBUG_PORT}" $@

    echo "**********************************************"
    echo Press q to break, or any other key to continue
    read answer

    if [[ ${answer} == "q" ]]; then
        break
    fi
done
