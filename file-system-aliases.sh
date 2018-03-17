#!/bin/bash

alias l='ls -la';
alias la='ls -la';

alias tree1='tree -L 1';
alias treeall='tree';

function treeit () {
  tree -L $1
}

function reloada () {
	source ~/.bash_profile
}

function mkdirgo () {
  mkdir $1 && cd $_ && pwd
}
