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

# overrides 'open' to make it cross platform
open(){ echo ${@:1}; ismac && command open ${@:1} || xdg-open "${@:1}" ;}

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

# reselt the console
alias r="reset"

# What's my ip addr?
myip(){
	addr=$(curl -s ifconfig.co -4)
	echo ${addr}
}

# generate ssh keys { email }
alias sgen='ssh-keygen -t rsa -b 4096 -C'

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