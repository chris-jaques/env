#!/bin/bash
#
# Get/Set data about env aliases
#
#

i-meta(){
    sudo apt-get update
    sudo apt-get install -y python3 python3-pip
    python3 -m pip install colorama --user
}
# Alias Search { keyword }
as(){
    clear
    python3 ~/env/search.py $1
}