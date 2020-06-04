#! /bin/bash

# github cli

alias git=hub

# GIT Stuff

# GIT Branch Management
alias gba='git branch -a' # List all branches, local and remote
alias gbr='git branch -r' # List all remote branches
alias gbv='git branch -vv' # List all local branches, verbosely

# Delete local branches not matching remote branches that have been deleted
alias gbp="git branch -vv | grep 'origin/.*: gone]' | awk '{print $1}' | xargs git branch -D"

# Git pretty
# export PS1="\[\e[32m\]\\$\[\e[m\]\[\e[32m\]\u\[\e[m\] : \[\e[32m\]\w\[\e[m\] : \[\e[34m\]\`parse_git_branch\`\[\e[m\] \n$ > "
# export PS1="\[\e[32m\]\w\[\e[m\] : \[\e[34m\]\`parse_git_branch\`\[\e[m\] \n$ > "
export PS1="|| \W > \[\e[34m\]\`parse_git_branch\`\[\e[m\] \n$ > "

# Git Shortcuts
alias gs='git status'
alias gb='git branch'
alias gca='git add . && git commit'
alias gitl='git log --decorate --oneline --graph --all'

alias githome='git config user.name "David R Poindexter III" && git config user.email "drpoindexter@gmail.com"'

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

gdevlog() {
	git log HEAD..origin/develop
}

git-trash() {
	git checkout .
	gs
}
