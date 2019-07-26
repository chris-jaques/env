#!/bin/bash
#
# Get/Set data about env aliases
#
#

# Alias Search { keyword }
as(){
    clear
    python3 ~/env/search.py $1
}