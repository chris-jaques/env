#!/bin/sh
#
# Terminal Math
#
#

# Install Terminal-Math
i_math(){
    # download dependencies
    sudo apt-get update && sudo apt-get install -y python3 xclip

    # push current dir to directory stack
    pushd .

    # Navigate to the dev directory ( defined in local.al )
    dev

    git clone git@github.com:chris-jaques/terminal-math.git
    cd terminal-math

    # symlink to ~/terminal-math.py
    ln -s $(pwd)/terminal-math.py ~/terminal-math.py

    # add an alias to the terminal-math project in local.al
    cda . math Terminal Math

    # return to previous dir
    popd
}

# Terminal-Math { expression }
m(){
    # Execute math function and copy results to clipboard
    python3 ~/terminal-math.py ${@:1} | cbcopy;

    # Output results to terminal
    cbpaste;
    
    # Echo for a new line
    echo "";
}
