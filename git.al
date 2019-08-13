#!/bin/sh
#
# Git
#
#

# Install git
i_git(){
	apt update && apt install -y git
}

# Show git Commit History
alias showgit='git log --oneline --abbrev-commit --all --graph --decorate --color'

# git status
alias gs='git status'

# clear and git status
alias cgs='c gs'

# reset and git status
alias gsr='r gs'

# git diff
alias gd='git diff'

# git branch
alias gb='git branch'

# git branch search { searchString }
gbs(){
	count=$(git branch -a | grep -c $1)
	if [ "$count" -eq 1 ]; then
		branch=$(gb -a | grep $1 | sed 's/remotes\/origin\///g')
		echo "$branch" | cbcopy
		echo -e "\e[93m$branch [copied]"
	else
		echo "$count matches:"
		gb -a | grep $1 | sed 's/remotes\/origin\///g'
	fi
}

# git add
alias ga='git add'

# git add dot
alias gad='ga .'

# git push { remote?=origin } { branch=master }
gup(){
	if [ -z $2 ]; then
		[ -z $1 ] && branch='master' || branch="$1"
		git push origin "$branch"
	else
		git push $1 $2
	fi
}

# git pull { remote?=origin } { branch=master }
gdown(){
	if [ -z $2 ]; then
		[ -z $1 ] && branch='master' || branch="$1"
		git pull origin "$branch"
	else
		git pull $1 $2
	fi
}

# git pull origin master
alias pm='gdown master'

# git push origin master
alias gum='gup master'

# reset all un-committed changes in git
alias gset='git reset; git checkout .; git clean -i -d'

# undo last git commit
alias gundo='git reset --soft HEAD~1'

# push local git changes to same branch on the origin
alias gsave='gup HEAD'

# git checkout { branch }
gc(){
	git checkout "$1"
}

# git checkout .
alias gc.='gc .'

# git checkout master
alias gcm='gc master'

# git checkout the branch that is in the clipboard
alias gccb='gc $(cbpaste)'

# clone a git repo for development { gitHost } { organization } { projectName } { cdAlias? } { ...label?=projectName }
gclone(){

	# cd into development dir
	dev;

	git clone git@$1.com:$2/$3.git;

	cd "$(basename $3)";

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

# git commit { ...message? }
gcom(){
	if [ -z $1 ]; then
		git commit
	else
		message="${@:1}"
		git commit -m "$message"
	fi
}
