## Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
# Q pre block. Keep at the top of this file.
eval $(thefuck --alias)

EDITOR=nvim

export EZA_CONFIG_DIR="${HOME}/.config/eza"

alias cat='bat'
alias git='hub'
alias tf='terraform'

alias todo='yatto'

alias lg='lazygit'

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'

alias awsume=". $(pyenv which awsume)"

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

export PATH="/usr/local/sbin:$PATH"
export PATH="$GOPATH/cobra-cli:$PATH"
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN
export GOPATH=$(go env GOPATH)
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

unalias 'ls'

alias ls='eza --icons=always'
alias lsa='eza -a --icons=always'
alias lsal='eza -la --icons=always'

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
source $ZSH/themes/alien/alien.zsh
export ALIEN_THEME="bnw"
export ALIEN_SECTIONS_LEFT=(
    exit
    time
    path
    newline
    ssh
    venv
    prompt
)
export ALIEN_SECTIONS_RIGHT=(
    vcs_branch:async
    vcs_status:async
    vcs_dirty:async
)
export ALIEN_SECTION_PATH_COMPONENTS=2
export ALIEN_VERSIONS_PROMPT='PYTHON_S NODE_S'
# source ~/alien/alien.zsh
# ZSH_THEME="alien"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
)

# source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
eval "$(pyenv init -)"

alias gitl='git log --decorate --oneline --graph --all'
alias gs='git status'
alias gca='git add . && git commit'


source $HOME/.cargo/env

# Q post block. Keep at the bottom of this file.
PATH=~/.console-ninja/.bin:$PATH


# Yazi alias
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"

# forgit plugin config
# Zsh:
# ~/.zshrc:
[ -f $HOMEBREW_PREFIX/share/forgit/forgit.plugin.zsh ] && source $HOMEBREW_PREFIX/share/forgit/forgit.plugin.zsh

alias cl='clear'
alias nvz='nv ~/.zshrc'
alias rl='source ~/.zshrc'


# tmux config
tmux source-file ~/tmux.conf

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/drpoindexter/.docker/completions $fpath)
autoload -Uz compinit
compinit

# End of Docker CLI completions

alias tm=tmux
alias nv=nvim

## Pomodoro Setup
alias work="timer 35m && terminal-notifier -message 'Pomodoro'\
            -title 'Work Timer is up! Take a break!'\
            -appIcon ''\
            -sound Crystal"

alias rest="timer 15m && terminal-notifier -message 'Pomodoro'\
            -title 'Break is over! Get back to work!'\
            -appIcon ''\
            -sound Crystal"

### Zoxide
eval "$(zoxide init --cmd cd zsh)"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/drpoindexter/.lmstudio/bin"
# End of LM Studio CLI section

