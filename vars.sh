DEBUG_PORT=5678

#local
LOCAL_ROOT=$(pwd)
LOCAL_DEBUGGER_ROOT=${LOCAL_ROOT}/remote_debug

#remote
REMOTE_ROOT=/opt
REMOTE_IDE_ROOT=${REMOTE_ROOT}/ide
REMOTE_DEBUGGER_ROOT=${REMOTE_IDE_ROOT}/remote_debug
REMOTE_DEBUGGER_LOG_PATH=${REMOTE_DEBUGGER_ROOT}/log

REMOTE_VENV_PATH=${REMOTE_ROOT}/ranger/venv
