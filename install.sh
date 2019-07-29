#!/bin/sh

# clone environment repo
cd ~/
git clone https://github.com/chris-jaques/env.git

# create a local alias file
if ! [ -f ~/env/local.al ]; then
    echo "#!/bin/bash\n#\n# Local Env\n# for directory aliases specific to this computer\n#\n#\n\n# Dev\nalias dev='cd ~/dev/'\n" > ~/env/local.al
fi

# apply environment
sh ~/env/apply.sh

# load the env
exec bash
