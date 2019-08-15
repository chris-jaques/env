#!/bin/sh
#
# Get/Set data about env aliases
#
#

# Install Metadata Tools
i_meta(){
    apt update
    apt install -y python3 less
}

# Alias Search { keyword }
as(){
    [ -z "$1" ] && args="" || args="${@:1}"
    python3 ~/env/search.py "$args" | less -r
}

# Alias Search(debug) { keyword }
asd(){
    [ -z "$1" ] && args="" || args="${@:1}"
    python3 ~/env/search.py "$args" -d | less -r
}
