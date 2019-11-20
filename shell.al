#!/bin/sh
# 
# Bash Helpers
#

# Install Powerline Shell
i_shell_env(){
  pinstall python-pip thefuck
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

# Copy to Clipboard { file? }
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

# override ls to always show hidden files with color.
alias ls='ismac && ls -a -G || ls -a --color'

# ls list
alias lsl='ismac && command ls -la -G || command ls -la --color'

# grep recursive, case-insensitive, filename only { searchString }
alias g='grep -ril'

# clear the console
alias c='clear;'

# reset the console
alias r="reset;"

# Exit the terminal after executing a command { command? }
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
  filename=${1:?Missing parameter: filename}
  from=${2:?Missing parameter: from}
  to=${3:?Missing parameter: to}
	find . -name $filename -print0 | xargs -0 sed -i "s/$from/$to/g"
}

# nano { filename? }
alias n='nano'

# Generic Map Storage - Retreive Value { key } { configFile=.envmap }
mapget(){
  key="${1:?Missing parameter: key}"

  [ -z "$2" ] && file=".envmap" || file="$2"
  file="$HOME/$file"
  # find in map file
  entry=$(grep "^$key:" $file)
  # parse value
  value=${entry/"$key:"/""}

  # Echo and copy value to clipboard
  echocopy "$key" "$value"
}

# Generic Map Storage - Set Value { key } { value } { configFile=.envmap }
mapset(){
  key="${1:?Missing parameter: key}"
  value="${2:?Missing parameter: value}"

  [ -z "$3" ] && file=".envmap" || file="$3"
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

# List all vars in the map storage { configFile=.envmap }
maplist(){
  [[ -z $1 ]] && file=".envmap" || file="$1"
  file="$HOME/$file"

  cat $file;
}

# Delete a Value from the Map Storage { key } { configFile=.envmap }
mapdel(){
  key="${1:?Missing parameter: key}"
  
  [ -z "$2" ] && file=".envmap" || file="$2"
  file="$HOME/$file"

  sed -i "/^$key\:/d" $file
}

# Reset Env
envr(){
  source "$(e;pwd)/loadEnv"
}

# Run Bash installer function with sudo { installerName }
sudo_i(){
  func=${1:?Missing parameter: installerName}
	sudo bash -c "$(declare -f i_$func);i_$func"
}

# Repeat the last command and pipe the results to Less
alias rl="fc -s | less -r"

# Get the Raw code from an alias { aliasName }
rawalias(){
  aliasName="${1:?Missing parameter: aliasName}"
  raw=$(grep -P "alias $aliasName=" $(e;pwd)/*.al | sed 's/.*=//g' | sed "s/[\'\"]//g")
  echo $raw;
}

# Echo a value (with an optional key) and copy it to the clipboard { key? } { value }
echocopy(){
  if [ -z "$2" ]; then
    value="${1:?Missing parameter: value}"
  else
    value="$2"
    key="$1"

    echo -e "\x1b[93m[ $key ]"
  fi

  echo $value | cbcopy
  echo -e "\x1b[0m${value}\x1b[93m\n[copied]\x1b[0m"
}
