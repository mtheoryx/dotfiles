#!/bin/bash

# iTerm tab color
source ~/dotfiles/iterm-tab-color.sh

# Help sourcing
source ~/dotfiles/help.sh

# $HOME sourcing
source ~/dotfiles/git-completion.bash

# Dotfiles sourcing
source ~/dotfiles/environment.sh
source ~/dotfiles/exports.sh
source ~/dotfiles/aliases.sh
source ~/dotfiles/git-utils.sh
source ~/dotfiles/nvm-utils.sh
source ~/dotfiles/file-system-aliases.sh
source ~/dotfiles/navigation-utils.sh
source ~/dotfiles/brew-utils.sh
source ~/dotfiles/stream-utils.sh

# tmux config
tmux source-file ~/dotfiles/tmux.conf

# Docker
source ~/dotfiles/docker-utils.sh

# Kubernetes
#source ~/dotfiles/kubernetes-utils.sh

# Terraform
source ~/dotfiles/terraform-utils.sh

# React
source ~/dotfiles/react-utils.sh

# Node
source ~/dotfiles/node-utils.sh

# BB-specific
#source ~/dotfiles/learn-backend-utils.sh
###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -n : -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
    if type __ltrim_colon_completions &>/dev/null; then
      __ltrim_colon_completions "${words[cword]}"
    fi
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###
