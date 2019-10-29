#!/bin/sh
#
# Get/Set data about env aliases
#
#

# Install Metadata Tools
i_meta(){
    pinstall python3 less
}

# Alias Search { ...keyword }
as(){
    keyword=${1:?Missing parameter: keyword}
    [ -z "$keyword" ] && args="" || args="${@:1}"

    matches=$(python3 $(e;pwd)/search.py "$args" | grep -ci "$args")
    if [[ $matches -gt 1 ]]; then
        python3 $(e;pwd)/search.py "$args" | less -r
    else
        python3 $(e;pwd)/search.py "$args"
    fi
}

# Alias Name Search { aliasName }
ans(){
    keyword=${1:?Missing parameter: keyword}
    [ -z "$keyword" ] && args="" || args="${@:1}"
 
    python3 $(e;pwd)/search.py "$args" -n
}

# Alias Search(debug) { keyword }
asd(){
    keyword=${1:?Missing parameter: keyword}
    [ -z "$keyword" ] && args="" || args="${@:1}"
    python3 $(e;pwd)/search.py "$args" -d | less -r
}
