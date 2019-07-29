#!/bin/sh
# 
# Bash Helpers
#

default_config='.envconf'

i-env(){
  line='curl https://raw.githubusercontent.com/chris-jaques/env/master/install.sh | sh'
  echo $line | cbcopy
  echo $line
}
bootstrapcmd(){
  echo 'curl https://raw.githubusercontent.com/chris-jaques/env/master/install.sh | sh && source ~/.bashrc' | cbcopy
}

# Is Mac?
ismac(){ [ "$(uname)" == "Darwin" ] ;}

# Copy to Clipboard { text }
ismac && alias cbcopy='pbcopy' || alias cbcopy='xclip -selection c'

# Paste from Clipboard
ismac && alias cbpaste='pbpaste' || alias cbpaste='xclip -selection clipboard -o'

# Initialize Desktop, navigate to LIFT dir and open Slack
alias init="nitrogen --restore; lift; slack &"

# override ls to always show hidden files.
alias ls='ls -a --color'

# ls list
alias lsl='ls -la'

# grep recursive, case-insensitive, filename only {searchString}
alias g='grep -ril'

# clear the console
alias c='clear'

# reset the console
alias r="reset"

# What's my ip addr?
myip(){
	addr=$(curl -s ifconfig.co -4)
	echo ${addr}
}

# generate ssh keys { label } { email }
shgen(){
	ssh-keygen -t rsa -N "" -f ~/.ssh/$1 -C $2
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/$1
}
#='pushd ~/.ssh; ssh-keygen -t rsa -b 4096 -C; popd'

# List ssh keys
alias shl="ls ~/.ssh | grep -v .pub"

# Get Public ssh key { name }
shget() {
	[[ -z "$1" ]] && key=~/.ssh/id_rsa.pub || key=~/.ssh/$1.pub
	cat $key | cbcopy
	cat $key
}

# String Replace { filename } { from } { to }
replaceAll(){
	find . -name $1 -print0 | xargs -0 sed -i "s/$2/$3/g"
}

# nano { filename }
alias n='nano'

# Jump to Parent Directories
alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'


# Generic Map Storage - Retreive Value {key}
mapget(){
  key="$1"
  [ -z "$2" ] && file=$default_config || file="$2"
  file="$HOME/$file"
  # find in map file
  value=$(grep "^$key:" $file)
  # parse and return value
  echo ${value/"$key:"/""}
}

# Generic Map Storage - Set Value {key} {value}
mapset(){
  key="$1"
  value="$2"
  [ -z "$3" ] && file=$default_config || file="$2"
  file="$HOME/$file"
  [ ! -f "$file" ] && touch "$file"
  # lookup existing value
  oldVal=$(grep "^$key:" $file)
  # write or replace key:value pair depending if it already exists
  if [ "$oldVal" == "" ]; then
    echo "$key:$value" >> $file
  else sed -i "/^$key:/c$key:$value" $file;
  fi
}

# Reset Env
alias envr="exec bash"

# Add a local cd alias { path } { alias } { ...label=path }
cda(){
  
  [ "$1" == "." ] && path=$(pwd) || path="$1"
  [ "$3" ] && label="${@:3}" || label="$path"

  if ! grep -q "^alias $2\=" ~/env/local.al; then
    echo "" >> ~/env/local.al
    echo "# $label" >> ~/env/local.al
    echo "alias $2='cd $path'" >> ~/env/local.al
  fi
}
