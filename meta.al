#!/bin/bash
#
# Get/Set data about env aliases
#
#

# Install Metadata Tools
i-meta(){
    sudo apt-get update
    sudo apt-get install -y python3 python3-pip less
    python3 -m pip install colorama --user
}
# Alias Search { keyword }
as(){
    python3 ~/env/search.py "$1" | less -r
}