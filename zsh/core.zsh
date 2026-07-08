# core.zsh — Cross-platform essentials (loaded on ALL machines)
# No OS-specific or machine-specific logic belongs here.

# ─── Editor ───────────────────────────────────────────────
export EDITOR=nvim

# ─── History ──────────────────────────────────────────────
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_verify

# ─── Core Aliases ─────────────────────────────────────────
alias nv=nvim
alias tm=tmux
alias cl='clear'
alias ..="cd .."

alias gitl='git log --decorate --oneline --graph --all'
alias gs='git status'
alias gca='git add . && git commit'

alias nvz='nv ~/.zshrc'
alias rl='source ~/.zshrc'

# ─── EZA (cross-platform, installed via package manager) ──
if command -v eza &>/dev/null; then
    export EZA_CONFIG_DIR="${HOME}/.config/eza"
    alias ls='eza --icons=always'
    alias lsa='eza -a --icons=always'
    alias lsal='eza -la --icons=always'
fi

# ─── Zoxide ───────────────────────────────────────────────
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)"
    alias cd="z"
fi

# ─── Yazi shell wrapper ───────────────────────────────────
if command -v yazi &>/dev/null; then
    function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
            builtin cd -- "$cwd"
        fi
        rm -f -- "$tmp"
    }
fi

# ─── Lazygit ──────────────────────────────────────────────
if command -v lazygit &>/dev/null; then
    alias lg='lazygit'
fi

# ─── bat (Ubuntu packages it as 'batcat') ─────────────────
if command -v bat &>/dev/null; then
    alias cat='bat'
elif command -v batcat &>/dev/null; then
    alias cat='batcat'
    alias bat='batcat'
fi

# ─── thefuck ─────────────────────────────────────────────
if command -v thefuck &>/dev/null; then
    eval $(thefuck --alias)
fi

# ─── Terraform ────────────────────────────────────────────
if command -v terraform &>/dev/null; then
    alias tf='terraform'
fi

# ─── chpwd — list on cd ──────────────────────────────────
chpwd() {
    if command -v eza &>/dev/null; then
        eza -a --icons=always
    else
        ls -a
    fi
}

# ─── NVM ──────────────────────────────────────────────────
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# ─── Cargo/Rust ───────────────────────────────────────────
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# ─── Go ───────────────────────────────────────────────────
if command -v go &>/dev/null; then
    export GOPATH=$(go env GOPATH)
    export GOBIN=$GOPATH/bin
    export PATH=$PATH:$GOBIN
fi

# ─── pyenv ────────────────────────────────────────────────
if command -v pyenv &>/dev/null; then
    eval "$(pyenv init -)"
fi
