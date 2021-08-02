### to install local dev system

{% codeblock installation lang:bash}
brew install ack
brew install libpcap
brew install Libxmlsec1
brew install pkg-config
brew install postgresql
brew install pypy3
brew install coreutils

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
