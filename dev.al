#!/bin/sh
#
# Development
#
#

# Install Vs Code
i-vscode(){
    sudo apt update
    sudo apt install -y software-properties-common apt-transport-https wget
    wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
    sudo apt update && sudo apt install -y code
}

# Edit the Env { file=local }
eenv(){ 
    [ -z "$1" ] && file="local.al" || file="$1.al"
    code ~/env "$(e;pwd)/$file"
}
