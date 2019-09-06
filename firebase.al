#!/bin/sh
# 
# Firebase
#

# Install Firebase
i_firebase(){
    # Just need to create the config folder
    mkdir -p ~/.config/configstore;
}
# Firebase { ...commands }
alias fb='dri -v $(pwd):/workspace -v ~/.config/configstore:/home/node/.config/configstore -w /workspace -u $(id -u) -p 9005:9005 andreysenov/firebase-tools firebase'
