#!/bin/sh
#
# Terminal Math
#

# Terminal Math image from Docker Hub
export ENV_DOCKER_IMAGE_TERMINAL_MATH="siege4/terminal-math:latest"

# Terminal-Math { ...expression }
m(){
    # Execute math function and copy results to clipboard
    docker run --rm -v ~/.terminal-math:/root/.terminal-math $ENV_DOCKER_IMAGE_TERMINAL_MATH ${@:1} | cbcopy;

    # Output results to terminal
    cbpaste;
    
    # Echo for a new line
    echo "";
}
