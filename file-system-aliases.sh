#!/bin/bash

alias l='ls -la';

alias treeitone='tree -L 1';

alias treeitall='tree';

treeit () {
  tree -L $1
}


reloada() {
	source ~/dotfiles/bashrc.sh
}
