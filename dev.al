#!/bin/sh
#
# Development
#
#

# Install Vs Code
i_vscode(){
    apt update
    apt install -y software-properties-common apt-transport-https wget
    wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add -
    add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
    apt update && apt install -y code
}

# Edit the Env { file=local }
eenv(){ 
    [ -z "$1" ] && file="local.al" || file="$1.al"
    code ~/env "$(e;pwd)/$file"
}
