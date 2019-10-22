#!/bin/sh
# 
# Bash Helpers
#


# generate ssh keys { label } { email }
shgen(){
	
	label=${1:?Missing parameter: label}
	email=${2:?Missing parameter: email}

	ssh-keygen -t rsa -N "" -f ~/.ssh/$label -C $email
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/$label
}

# List ssh keys
alias shl="ls ~/.ssh | grep .pub | sed 's/.pub//g'"

# Get Public ssh key { label }
shget() {
	label=${1:?Missing parameter: label}

	[[ -z "$label" ]] && key=~/.ssh/id_rsa.pub || key=~/.ssh/$label.pub
    if [ -f "$key" ]; then
	    value=$(cat $key)
	    echocopy "$key" "$value"
    else
        echo "No public key Found for $label."
    fi
}
