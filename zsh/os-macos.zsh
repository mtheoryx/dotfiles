# os-macos.zsh — macOS-specific configuration
# Only sourced on Darwin systems.

# ─── Homebrew ─────────────────────────────────────────────
# .zprofile handles brew shellenv for login shells.
# This catches non-login interactive shells (e.g., tmux panes).
if [[ -z "$HOMEBREW_PREFIX" ]]; then
    if [[ -f /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -f /usr/local/bin/brew ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
fi

# Prevent pyenv shims from breaking brew
if command -v pyenv &>/dev/null; then
    alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
fi

# ─── forgit (installed via Homebrew) ──────────────────────
if [[ -n "$HOMEBREW_PREFIX" ]] && [[ -f "$HOMEBREW_PREFIX/share/forgit/forgit.plugin.zsh" ]]; then
    source "$HOMEBREW_PREFIX/share/forgit/forgit.plugin.zsh"
fi

# ─── zsh-syntax-highlighting (Homebrew) ───────────────────
if [[ -n "$HOMEBREW_PREFIX" ]] && [[ -f "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# ─── OrbStack ─────────────────────────────────────────────
[[ -f ~/.orbstack/shell/init.zsh ]] && source ~/.orbstack/shell/init.zsh

# ─── Docker Desktop completions ───────────────────────────
if [[ -d "$HOME/.docker/completions" ]]; then
    fpath=($HOME/.docker/completions $fpath)
fi

# ─── macOS Apps ───────────────────────────────────────────
if [[ -d "/Applications/Kiro CLI.app" ]]; then
    alias kiro-cli="/Applications/Kiro\ CLI.app/contents/MacOS/kiro-cli"
fi

# ─── hub (GitHub CLI wrapper) ─────────────────────────────
if command -v hub &>/dev/null; then
    alias git='hub'
fi

# ─── awsume ───────────────────────────────────────────────
if command -v pyenv &>/dev/null && pyenv which awsume &>/dev/null 2>&1; then
    alias awsume=". $(pyenv which awsume)"
fi

# ─── Pomodoro (requires terminal-notifier) ────────────────
if command -v terminal-notifier &>/dev/null && command -v timer &>/dev/null; then
    alias work="timer 35m && terminal-notifier -message 'Pomodoro'\
                -title 'Work Timer is up! Take a break!'\
                -appIcon ''\
                -sound Crystal"

    alias rest="timer 15m && terminal-notifier -message 'Pomodoro'\
                -title 'Break is over! Get back to work!'\
                -appIcon ''\
                -sound Crystal"
fi

# ─── LM Studio ───────────────────────────────────────────
[[ -d "$HOME/.lmstudio/bin" ]] && export PATH="$PATH:$HOME/.lmstudio/bin"

# ─── console-ninja ────────────────────────────────────────
[[ -d "$HOME/.console-ninja/.bin" ]] && PATH="$HOME/.console-ninja/.bin:$PATH"

# ─── yatto ────────────────────────────────────────────────
if command -v yatto &>/dev/null; then
    alias todo='yatto'
fi

# ─── weather ──────────────────────────────────────────────
if command -v rustormy &>/dev/null; then
    alias weather='rustormy -c Indianapolis --colors'
fi
