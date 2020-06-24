#!/bin/sh
# 
# Firebase
#

# Pull latest version of firebase image
alias _docker_pull_firebase="dpq andreysenov/firebase-tools"

# Firebase { ...commands }
fb(){
    # Ensure config folder exists
    mkdir -p ~/.config/configstore;
    
    dri -v $(pwd):/workspace -v ~/.config/configstore:/home/node/.config/configstore -w /workspace -u $(id -u) -p 9005:9005 andreysenov/firebase-tools firebase
}
