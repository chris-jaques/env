#!/bin/sh
#
# Get/Set data about env aliases
#
#

# Env-Search image from Docker Hub
export ENV_DOCKER_IMAGE_ENV_SEARCH="siege4/env-search:latest"

# Dockerized Alias Search { ...keyword }
alias-search(){
    docker run --rm -v $(e;pwd):/root/env $ENV_DOCKER_IMAGE_ENV_SEARCH "${@:1}"
}

# Alias Search { ...keyword }
as(){
    keyword=${1:?Missing parameter: keyword}
    [ -z "$keyword" ] && args="" || args="${@:1}"

    matches=$(alias-search "$args" | grep -ci "$args")
    if [[ $matches -gt 1 ]]; then
        alias-search "$args" | less -r
    else
        alias-search "$args"
    fi
}

# Alias Name Search { aliasName }
ans(){
    keyword=${1:?Missing parameter: keyword}
    [ -z "$keyword" ] && args="" || args="${@:1}"
 
    alias-search "$args" -n
}

# Alias Search(debug) { keyword }
asd(){
    keyword=${1:?Missing parameter: keyword}
    [ -z "$keyword" ] && args="" || args="${@:1}"
    alias-search "$args" -d | less -r
}
