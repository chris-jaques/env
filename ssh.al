#!/bin/sh
# 
# Bash Helpers
#


# generate ssh keys { label } { email }
shgen(){
	ssh-keygen -t rsa -N "" -f ~/.ssh/$1 -C $2
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/$1
}

# List ssh keys
alias shl="ls ~/.ssh | grep .pub | sed 's/.pub//g'"

# Get Public ssh key { name }
shget() {
	[[ -z "$1" ]] && key=~/.ssh/id_rsa.pub || key=~/.ssh/$1.pub
    if [ -f "$key" ]; then
	    cat $key | cbcopy
	    echo -e "\e[93m[ $key ]\n\e[0m$(cbpaste)\e[93m\n[copied]"
    else
        echo "No public key Found for $1."
    fi
}
