### to install local dev system

{% codeblock installation lang:bash}
brew install java
brew install graphviz
brew install ack
brew install ag
brew install rg
brew install libpcap
brew install Libxmlsec1
brew install pkg-config
brew install postgresql
brew install pypy3
brew install coreutils
brew install clang
brew install llvm
brew install clang-format

#for pytest covarage
pip install -U coverage==5.0.0
pip install -U pytest-cov==2.8.0
pip install -U py.test

#for cpp debug
brew install gdb

# remove unnecessary requirements that cause conflicts
./prepare_venv.sh <PROJ_NAME>

./nvim.sh <PROJ_NAME> .
{% endcodeblock %}

### how to debug rangaer

{% codeblock deugging lang:bash %}
# make sure you are on the projects root

#pull image
docker pull registry.t82.co/ranger:latest

#run ranger container
./dispatch_rangeer_container.sh

#inside the container, run debugpy
dev
cd ..
./remote_debug/debug_forever.sh -m lkpo.lkpo_magic r -f --bm

{% endcodeblock %}

### cpp
generate compile_commands.json for your project.

ln -s <PATH_TO_COMPILE_COMMANDS> <PROJ_ROOT>/compile_commands.json

now coc-clangd will know how to parse your code

## other
npm i -g vscode-langservers-extracted
npm install -g dockerfile-language-server-nodejs
npm i -g bash-language-server
pip install cmake-language-server
