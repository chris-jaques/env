#!/bin/sh
#
# Directory-related aliases
#
#


# Jump to Parent Directory { levels=1 }
..(){
  [ -z "$1" ] && levels=1 || levels=$(("$1"))
  i=0
  while [ $i -lt $levels ]
  do
    cd ..
    i=$(($i + 1))
  done
}

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

# Remove a local cd alias { alias }
cdr(){

  line=$(grep -n "alias $1=" ~/env/local.al | grep -Eo "^[^:]+")
  start=$(($line - 2))
  
  sed -i "$start,$line"d ~/env/local.al

  envr;
}

# Modify a local cd alias { oldAlias } { newAlias }
cdm(){
  sed -i "s/alias $1=/alias $2=/g" ~/env/local.al

  envr;
}