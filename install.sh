#!/bin/sh

# Test for dependencies ( `git`, `grep` )
if ! [ "$( command -v git)" ] || ! [ "$(command -v grep )" ]; then
     
    echo 'missing dependencies'

    # Test for package managers
    if [ "$(command -v apk)" ]; then
        updatecmd='apk update'
        installcmd='apk add'
    elif [ "$(command -v apt)" ]; then
        updatecmd='apt update'
        installcmd='apt install -y'
    elif [ "$(command -v brew)" ]; then
        updatecmd='brew update'
        installcmd='brew install'
    else
        echo 'A package manager {{ apk / apt / brew }} is required to install dependencies for env' >&2
        exit 1;
    fi

    # sudo if needed
    [ $(id -u) -ne 0 ] && updatecmd="sudo $updatecmd" && installcmd="sudo $installcmd"

    # download dependencies
    echo "Attempting to Install Dependencies with { $updatecmd; $installcmd git grep }"
    $updatecmd; $installcmd git grep
fi

# clone environment repo
if ! [ -d ~/env ]; then
    cd ~/
    echo "Cloning repo..."
    git clone https://github.com/chris-jaques/env.git
fi

# create a local alias file
if ! [ -f ~/env/local.al ]; then
    echo "Creating local.al"
    cat <<EOL > ~/env/local.al
#!/bin/sh
#
# Local Env
# for directory aliases specific to this computer
#
#
# Env
alias e='cd ~/env'

# Root dir for dev projects
alias dev='cd ~/dev'
EOL
    # ensure ~/dev exists
    mkdir -p ~/dev
fi

if ! [ -L ~/.vimrc ]; then
    [ -f ~/.vimrc ] && rm ~/.vimrc
    ln -s ~/env/.vimrc ~/.vimrc
fi

case $SHELL in
    *bash)
        shell_config=~/.bashrc
    ;;
    *zsh)
        shell_config=~/.zshenv
    ;;
    default)
        shell_config=~/.profile
esac

# apply environment
if ! grep -q "~/env/loadEnv" $shell_config; then
    echo "adding loadEnv to $shell_config"
    echo "# Source the env
. ~/env/loadEnv" >> $shell_config
fi
