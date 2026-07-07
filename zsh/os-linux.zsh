# os-linux.zsh — Linux-specific configuration
# Only sourced on Linux systems.

# ─── Linuxbrew (if installed) ─────────────────────────────
# .zprofile handles brew shellenv for login shells.
# This catches non-login interactive shells (e.g., tmux panes).
if [[ -z "$HOMEBREW_PREFIX" ]]; then
    if [[ -d /home/linuxbrew/.linuxbrew ]]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    elif [[ -d "$HOME/.linuxbrew" ]]; then
        eval "$("$HOME/.linuxbrew/bin/brew" shellenv)"
    fi
fi

# ─── zsh-syntax-highlighting (apt or brew) ────────────────
if [[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ -n "$HOMEBREW_PREFIX" ]] && [[ -f "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# ─── forgit ───────────────────────────────────────────────
if [[ -f /usr/share/forgit/forgit.plugin.zsh ]]; then
    source /usr/share/forgit/forgit.plugin.zsh
elif [[ -n "$HOMEBREW_PREFIX" ]] && [[ -f "$HOMEBREW_PREFIX/share/forgit/forgit.plugin.zsh" ]]; then
    source "$HOMEBREW_PREFIX/share/forgit/forgit.plugin.zsh"
fi

# ─── hub ──────────────────────────────────────────────────
if command -v hub &>/dev/null; then
    alias git='hub'
fi

# ─── weather ──────────────────────────────────────────────
if command -v rustormy &>/dev/null; then
    alias weather='rustormy -c Indianapolis --colors'
fi
