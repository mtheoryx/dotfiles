# plugins.zsh — Oh-My-Zsh, theme, and plugin configuration
# Skipped on lightweight/server profiles for fast startup.

# ─── Oh-My-Zsh ───────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"

plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
)

source "$ZSH/oh-my-zsh.sh"

# ─── Alien Theme ──────────────────────────────────────────
if [[ -f "$ZSH/themes/alien/alien.zsh" ]]; then
    source "$ZSH/themes/alien/alien.zsh"
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
        battery
    )
    export ALIEN_SECTION_PATH_COMPONENTS=2
    export ALIEN_VERSIONS_PROMPT='PYTHON_S NODE_S'
fi

# ─── Completions ──────────────────────────────────────────
autoload -Uz compinit
compinit

autoload -U +X bashcompinit && bashcompinit

# Terraform completion (path-independent)
if command -v terraform &>/dev/null; then
    complete -o nospace -C "$(command -v terraform)" terraform
fi
