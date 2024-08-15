alias tmux='tmux -2'
export ALIASES_DIR="${HOME}/notes/environment/aliases"
pushd $ALIASES_DIR > /dev/null
source load.sh
popd > /dev/null

export CODE_DIR_PATH=$(_tmux_guess_workdir_path)
export GRANTED_ENABLE_AUTO_REASSUME=true
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$HOME/.local/share/bob/nvim-bin/:$PATH

export TERM=tmux-256color
export LC_ALL=en_IN.UTF-8
export LANG=en_IN.UTF-8

export EDITOR="nvim"
export VISUAL="nvim"
export PROJECTPATH="$HOME/work"

# export PAGER="nvimpager -p"

set -o vi

source ${HOME}/.secrets

ulimit -n 10240

alias go=/usr/local/go/bin/go
