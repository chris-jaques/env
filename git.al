#!/bin/bash
#
# Git
#
#

# Install git
i-git(){
	sudo apt-get update && sudo apt-get install git
}
# Show git Commit History
alias showgit='git log --oneline --abbrev-commit --all --graph --decorate --color'

# git status
alias gs='git status'

# clear and git status
alias cgs='c;gs'

# reset and git status
alias gsr='r;gs'

# git diff
alias gd='git diff'

# git branch
alias gb='git branch'

# git add
alias ga='git add'

# git add dot
alias gad='ga .'

# git push { remote=origin } { branch }
gup(){
	if [ -z $2 ]; then
		git push origin $1
	else
		git push $1 $2
	fi
}

# git pull { remote=origin } { branch }
gdown(){
	if [ -z $2 ]; then
		git pull origin $1
	else
		git pull $1 $2
	fi
}

# git pull origin master
alias gdm='gdown master'

# git push origin master
alias gum='gup master'

# reset all un-committed changes in git
alias gset='git reset; git checkout .; git clean -i -d'

# undo last git commit
alias gundo='git reset --soft HEAD~1'

# push local git changes to same branch on the origin
alias gsave='gup HEAD'

# git checkout master
alias gcm='git checkout master'

# clone a git repo for development { gitHost } { organization } { projectName } { cdAlias? } { ...label?=projectName }
gclone(){

	# cd into development dir
	dev;

	git clone git@$1.com:$2/$3.git;

	cd "$3";

	if [ "$4" ]; then
		[ "$5" ] && label="${@:5}" || label="$3"
	
		# Add local alias for this project
		cda . "$4" "$label";
	fi
}

# Clone a GitHub repo { organization } { projectName } { cdAliax? } { ...label?=projectName }
alias ghc='gclone github'

# Clone a GitLab repo { organization } { projectName } { cdAliax? } { ...label?=projectName }
alias glc='gclone gitlab'
