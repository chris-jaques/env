#!/bin/sh

# clone environment repo
cd ~/
git clone https://github.com/chris-jaques/env.git

# create a local alias file
if ! [ -f ~/env/local.al ]; then
    echo "#!/bin/sh\n#\n# Local Env\n# for directory aliases specific to this computer\n#\n#\n# Env\nalias e='cd ~/env'\n\n# Root dir for dev projects\nalias dev='cd ~/dev'" > ~/env/local.al
fi

# apply environment
if ! grep -q "~/env/loadEnv" ~/.bashrc; then
    echo "source ~/env/loadEnv" >> ~/.bashrc
fi

# load the env
. ~/env/loadEnv

