#!/usr/bin/env bash
# setup-dotfiles.sh — Run after bootstrap to activate the new config
# Usage: bash ~/dotfiles/bootstrap/setup-dotfiles.sh [server|desktop]

set -euo pipefail

PROFILE="${1:-server}"
DOTFILES_DIR="$HOME/dotfiles"

cd "$DOTFILES_DIR"

echo "→ Copying .new files into place..."
cp zsh/.zshrc.new zsh/.zshrc
cp zsh/.zprofile.new zsh/.zprofile
cp zsh/.zshenv.new zsh/.zshenv

echo "→ Backing up existing configs..."
for f in ~/.zshrc ~/.zprofile ~/.zshenv; do
    if [[ -f "$f" && ! -L "$f" ]]; then
        mv "$f" "${f}.backup"
        echo "  Backed up $f"
    fi
done

echo "→ Stowing packages..."
stow -R zsh
stow -R tmux
stow -R nvim

echo "→ Setting profile to: $PROFILE"
echo "export DOTFILES_PROFILE=$PROFILE" > ~/.zshrc.local

echo ""
echo "Done! Run: exec zsh"
echo "If anything breaks: exec bash"
