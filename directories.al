#!/bin/sh
#
# Directory-related aliases
#
#


# Jump to Parent Directories
alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'

# Add a local cd alias { path } { alias } { ...label=path }
cda(){
  
  [ "$1" == "." ] && path=$(pwd) || path="$1"
  [ "$3" ] && label="${@:3}" || label="$path"

  if ! grep -q "^alias $2\=" ~/env/local.al; then
    echo "" >> ~/env/local.al
    echo "# $label" >> ~/env/local.al
    echo "alias $2='cd $path'" >> ~/env/local.al
  fi

  # reload env to apply new alias
  envr;
}
