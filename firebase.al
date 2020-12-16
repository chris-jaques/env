#!/bin/sh
# 
# Firebase
#

# Firebase image from Docker Hub
export ENV_DOCKER_IMAGE_FIREBASE="andreysenov/firebase-tools:latest"

# Firebase { ...commands }
fb(){
    # Ensure config folder exists
    mkdir -p ~/.config/configstore;

    docker run --rm -it -v $(pwd):/workspace -v ~/.config/configstore:/home/node/.config/configstore -w /workspace -u $(id -u) -p 9005:9005 $ENV_DOCKER_IMAGE_FIREBASE firebase
}
