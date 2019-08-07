#!/bin/sh

# Test for dependencies ( `git`, `grep` )
if [ command -v git >/dev/null 2>&1 && command -v grep >/dev/null 2>&1 ]; then    
     command -v git && command -v grep
    echo 'missing dependencies'
    # Test for package managers
    if command -v apk >/dev/null 2>&1; then
        updatecmd='apk update'
        installcmd='apk add'
    elif command -v apt >/dev/null 2>&1; then
        updatecmd='apt update'
        installcmd='apt install -y'
    elif command -v brew > /dev/null 2>&1; then
        updatecmd='brew update'
        installcmd='brew install'
    else
        echo 'A package manager {{ apk / apt / brew }} is required to install dependencies for env' >&2
        exit 1;
    fi

    # sudo if needed
    [ $(id -u) -ne 0 ] && updatecmd="sudo $updatecmd";installcmd="sudo $installcmd"

    # download dependencies
    $updatecmd; $installcmd git grep
fi

# clone environment repo
if ! [ -d ~/env ]; then
    cd ~/
    git clone https://github.com/chris-jaques/env.git
fi

# create a local alias file
if ! [ -f ~/env/local.al ]; then
    echo "#!/bin/sh\n#\n# Local Env\n# for directory aliases specific to this computer\n#\n#\n# Env\nalias e='cd ~/env'\n\n# Root dir for dev projects\nalias dev='cd ~/dev'" > ~/env/local.al
    mkdir -p ~/dev
fi

# apply environment
if ! grep -q "~/env/loadEnv" ~/.bashrc; then
    echo "# Source the env \n. ~/env/loadEnv" >> ~/.bashrc
fi

# Pull latest env version from git on bash startup
if ! grep -q "git.*~/env pull origin master" ~/.bashrc; then
    # Pull latest version of env down from git
    echo "# Pull latest version of env from github\ngit -C ~/env pull origin master &> /dev/null;" >> ~/.bashrc
fi
