#!/bin/sh
#
# Package Management
#

# Package Install { ...packageName }
pinstall(){
    packageName=${1:?Missing parameter: packageName}
    # Test for package managers
    if [ "$(command -v apk)" ]; then
        apk update
        apk add ${@:1}
    elif [ "$(command -v yum)" ]; then
        yum update
        yum install -y ${@:1}
    elif [ "$(command -v brew)" ]; then
        brew update
        echo | brew install ${@:1}
    elif [ "$(command -v apt)" ]; then
        apt update
        apt install -y ${@:1}
    else
        echo 'A package manager {{ apk / apt / yum / brew }} is required to install dependencies for env' >&2
        exit 1;
    fi
}
