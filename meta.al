#!/bin/bash
#
# Get/Set data about env aliases
#
#

i-meta(){
    sudo apt-get update
    sudo apt-get install -y python3
    pip install --upgrade pip
    pip install colorama
}
# Alias Search { keyword }
as(){
    clear
    python3 ~/env/search.py $1
}