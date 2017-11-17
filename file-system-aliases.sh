#!/bin/bash

alias l='ls -la';

alias tree1='tree -L 1';

alias treeall='tree';

treeit () {
  tree -L $1
}

reloada() {
	source ~/dotfiles/bashrc.sh
}
