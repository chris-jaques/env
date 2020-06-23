#!/bin/sh
#
# Terminal Math
#

# Terminal Math image tag to pull from Docker Hub
export TERMINAL_MATH_IMAGE_VERSION="latest"

# Pull latest version of terminal-math
alias _pull_tm='dpq siege4/terminal-math:$TERMINAL_MATH_IMAGE_VERSION'

# Terminal-Math { ...expression }
m(){
    # Execute math function and copy results to clipboard
    dri -v ~/.terminal-math:/root/.terminal-math siege4/terminal-math:${TERMINAL_MATH_IMAGE_VERSION} m ${@:1} | cbcopy;

    # Output results to terminal
    cbpaste;
    
    # Echo for a new line
    echo "";
}
