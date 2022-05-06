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
	[[ -z "$label" ]] && key_name="${HOME}/.ssh/id_rsa.pub" || key_name="${HOME}/.ssh/$label.pub"
    if [ -f "$key_name" ]; then
	    value=$(cat $key_name)
	    echocopy "$key_name+++
		
		
		
		-*" "$value"
    else
        echo "No public key Found for $label."
    fi
}
