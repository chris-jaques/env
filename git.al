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
	search=${1:?Missing parameter: searchString}
	count=$(gb -a | grep $search | sed 's/remotes\/origin\///g' | uniq | grep -c $search)
	if [ "$count" -eq 1 ]; then
		branch=$(gb -a | grep $search | sed 's/remotes\/origin\///g' | uniq )
		echo "$branch" | cbcopy
		echo -e "\x1b[93m$branch [copied]"
	else
		echo "$count matches:"
		gb -a | grep $search | sed 's/remotes\/origin\///g' | uniq
	fi
}

# git add
alias ga='git add'

# git add dot
alias gad='ga .'

# git push { remote?=origin } { branch=HEAD }
gup(){
	if [ -z $2 ]; then
		[ -z $1 ] && branch='HEAD' || branch="$1"
		git push origin "$branch"
	else
		git push $1 $2
	fi
}

# git pull { remote?=origin } { branch=HEAD }
gdown(){
	if [ -z $2 ]; then
		[ -z $1 ] && branch='HEAD' || branch="$1"
		git pull origin "$branch"
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

# git checkout { branchName }
gc(){
	branch=${1:?Missing parameter: branchName}
	git checkout "$branch"
}

# git checkout .
alias gc.='gc .'

# git checkout master
alias gcm='gc master'

# git checkout the branch that is in the clipboard
alias gccb='gc $(cbpaste)'

# create a new branch { branchName }
alias gcb='git checkout -b'

# clone a git repo for development { gitHost } { organization } { projectName } { cdAlias? } { ...label?=projectName }
gclone(){

	gitHost=${1:?Missing parameter: gitHost}
	org=${2:?Missing parameter: organization}
	proj=${3:?Missing parameter: projectName}
	alias=$4

	# cd into development dir
	dev;

	git clone git@${gitHost}.com:${org}/${proj}.git;

	cd "$(basename $proj)";

	if [ -n "$alias" ]; then
		[ -n "$5" ] && label="${@:5}" || label="$proj"
	
		# Add local alias for this project
		cda . "$alias" "$label";
	fi
}

# Clone a GitHub repo { organization } { projectName } { cdAliax? } { ...label?=projectName }
alias ghc='gclone github'

# Clone a GitLab repo { organization } { projectName } { cdAliax? } { ...label?=projectName }
alias glc='gclone gitlab'

# Create a Git Repo { gitHost } { organization } { projectName } { cdAlias? } { ...label?=projectName }
gcreate(){

	gitHost=${1:?Missing parameter: gitHost}
	org=${2:?Missing parameter: organization}
	proj=${3:?Missing parameter: projectName}
	alias=$4

	#cd into development dir
	dev;

	mkdir "$proj";
	cd "$proj";

	# Initialize git with an empty README
	# ( for something to commit )
	git init;
	echo "#New Project" > README.md;

	# Add and Commit
	gac initial commit;

	# Add the remote
	git remote add orign git@${gitHost}.com:${org}/${proj}.git;

	# push origin master
	gup;

	if [ -n "$alias" ]; then
		[ -n "$5" ] && label="${@:5}" || label="$proj"
	
		# Add local alias for this project
		cda . "$alias" "$label";
	fi
}


# Create a GitHub repo { organization } { projectName } { cdAlias? } { ...label?=projectName }
alias ghcreate='gcreate github'

# Create a GitLab repo { organization } { projectName } { cdAlias? } { ...label?=projectName }
alias glcreate='gcreate gitlab'

# git commit { ...message? }
gcom(){
	if [ -z $1 ]; then
		git commit
	else
		message="${@:1}"
		git commit -m "$message"
	fi
}

# git add all modified files and commit { ...message? }
alias gac='gad;gcom'

# git add all modified files, commit, and push up { ...message? }
gacs(){
	gac ${@:1};
	gup;
}

# Git Ignore: Preview a .gitignore from gitignore.io { programmingLanguage }
gi(){
	lang=${1:?Missing parameter: programmingLanguage}
	curl -sL gitignore.io/api/"$1"
}

# Git Ignore Save: Grab a .gitignore from gitignore.io and save it to the current project { programmingLanguage }
gis(){
	gi "$1" > .gitignore
}
