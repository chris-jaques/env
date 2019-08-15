#!/bin/sh
# 
# Bash Helpers
#

# Install Powerline Shell
i_powerline(){
  apt update && apt install -y python-pip
  pip install powerline-shell
}

# Copy install command to the clipboard
bootstrapcmd(){
  line='curl https://raw.githubusercontent.com/chris-jaques/env/master/install.sh | sh'
  echo $line | cbcopy
  echo $line
}

# Is Mac?
ismac(){ 
  [ "$(uname)" == "Darwin" ] ;
}

# Copy to Clipboard { file }
cbcopy(){
  if ismac; then
    pbcopy $1
  else
    xclip -selection c $1
  fi
}

# Paste from Clipboard
cbpaste(){
  if ismac; then
    pbpaste
  else
    xclip -selection clipboard -o
  fi
}

# override ls to always show hidden files.
alias ls='ls -a --color'

# ls list
alias lsl='ls -la'

# grep recursive, case-insensitive, filename only {searchString}
alias g='grep -ril'

# clear the console
alias c='clear;'

# reset the console
alias r="reset;"

# Exit the terminal after executing a command { command }
x(){
  "${@:1}";exit;exit
}

# What's my ip addr?
myip(){
	addr=$(curl -s ifconfig.co -4)
	echo ${addr}
}

# String Replace { filename } { from } { to }
replaceAll(){
	find . -name $1 -print0 | xargs -0 sed -i "s/$2/$3/g"
}

# nano { filename }
alias n='nano'

# Generic Map Storage - Retreive Value {key}
mapget(){
  key="$1"
  [ -z "$2" ] && file=".envmap" || file="$2"
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
  [ -z "$3" ] && file=".envmap" || file="$2"
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
envr(){
  source "$(e;pwd)/loadEnv"
}

# Run Bash installer function with sudo
sudo_i(){
	sudo bash -c "$(declare -f i_$1);i_$1"
}

# Repeat the last command and pipe the results to Less
alias rl="fc -s | less -r"
