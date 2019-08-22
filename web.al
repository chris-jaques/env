#!/bin/sh
#
# Web Browser Aliases
#
#

# Install Chrome Browser
i_chrome(){
    cd ~/Downloads
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    dpkg -i google-chrome-stable_current_amd64.deb
    rm google-chrome-stable_current_amd64.deb
}


# open web browser { website } { queryString }
web(){ 
    url="http://"$1"${@:2}";
    echo $url;
    ismac && command open "$url" || xdg-open "$url" ;
}

# Google Search { ...searchString }
goo(){
    searchString="${@:1}"
    web www.google.com/search?q= "$searchString"
}

# SuperLIFT Invoice Breakdown { invoiceNumber }
alias inv="web superlift.theliftsystem.com/invoices/breakdown/"

# Docker Hub Search { search }
alias dh="web hub.docker.com/search?q="

# Docker hub Lucky Search { search }
alias dhl="web hub.docker.com/_/"

# explain Shell { cmd }
xsh(){
    cmd="${@:1}"
    web explainshell.com/explain?cmd= "$cmd"
}

# explain Shell for the previous command
xprev(){
    xsh $(fc -ln | tail -2 | head -1)
}
