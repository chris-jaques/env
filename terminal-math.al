#!/bin/sh
#
# Terminal Math
#

# Terminal-Math { ...expression }
m(){
    # Execute math function and copy results to clipboard
    dri -v ~/.terminal-math:/root/.terminal-math siege4/terminal-math:latest m ${@:1} | cbcopy;

    # Output results to terminal
    cbpaste;
    
    # Echo for a new line
    echo "";
}
