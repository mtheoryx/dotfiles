# $HOME sourcing
source ~/.git-completion.bash

# Dotfiles sourcing
source ~/dotfiles/.environment
source ~/dotfiles/.exports
source ~/dotfiles/.git-utils
source ~/dotfiles/.nvm-utils
source ~/dotfiles/.file-system-aliases

# BB-specific
source ~/dotfiles/.learn-backend-utils

mybash() {
	(cd ~/dotfiles; atom .)
}
godots() {
  cd ~/dotfiles
}
