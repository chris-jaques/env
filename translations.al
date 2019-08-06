#!/bin/sh
#
# Google Translation API
#
#

# Install Translate-Shell
i_trans(){
    pushd ~/Downloads
    wget git.io/trans
    sudo apt install gawk
    sudo chmod +x ./trans
    sudo mv trans /usr/local/bin/trans
}
# Translate Chinese to English
alias t='trans zh:en'

# Translate to Chinese (simplified)
alias z='trans :zh'

# Translate to Chinese (traditional)
alias zt='trans :zh-TW'