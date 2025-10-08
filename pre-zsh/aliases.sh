#! /bin/sh

# just for speed, convenience
alias v='vim'

# Syntax highlighting and line numbers
# https://github.com/sharkdp/bat
# Installed via BREW
alias cat='bat'

# Will move things to Mac trash instead of forever delete
# https://hasseg.org/trash/
# Installed via BREW
alias rm='trash'

# Helps with fixing errors on previous command
# https://nvbn.github.io/2015/10/08/how-thefuck-works/
# https://github.com/nvbn/thefuck
# Installed via BREW
eval $(thefuck --alias)
