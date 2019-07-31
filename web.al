#!/bin/sh
#
# Web Browser Aliases
#
#

# Install Chrome Browser
i-chrome(){
    cd ~/Downloads
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome-stable_current_amd64.deb
    rm google-chrome-stable_current_amd64.deb
}


# open web browser { website } { queryString }
web(){ 
    echo $1${@:2} 
    ismac && command open $1"${@:2}" || xdg-open $1"${@:2}" ;
}

# Google Search { ...searchString }
goo(){
    searchString="${@:1}"
    web https://www.google.com/search?q= "$searchString"
}

# SuperLIFT Invoice Breakdown { invoiceNumber }
alias inv="web https://superlift.theliftsystem.com/invoices/breakdown/"

# Docker Hub Search { search }
alias dh="web https://hub.docker.com/search?q="

# Docker hub Lucky Search { search }
alias dhl="web https://hub.docker.com/_/"

# explain Shell { cmd }
alias xsh='web https://explainshell.com/explain?cmd='