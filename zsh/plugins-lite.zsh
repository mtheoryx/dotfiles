# plugins-lite.zsh — Minimal prompt for servers and low-power devices
# No Oh-My-Zsh, no async git, no heavy themes. Fast startup.

# ─── Simple prompt ────────────────────────────────────────
# Shows: user@host:path (git-branch) $
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' (%b)'
setopt PROMPT_SUBST
PROMPT='%n@%m:%~${vcs_info_msg_0_} %# '

# ─── Completions (lightweight) ────────────────────────────
autoload -Uz compinit
compinit

autoload -U +X bashcompinit && bashcompinit

# Terraform completion (path-independent)
if command -v terraform &>/dev/null; then
    complete -o nospace -C "$(command -v terraform)" terraform
fi
