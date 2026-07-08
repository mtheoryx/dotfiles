#!/usr/bin/env bash
# bootstrap-ubuntu.sh — Prepare a bare Ubuntu machine for dotfiles
# Run as your user (will sudo when needed).
# Usage: bash bootstrap-ubuntu.sh [profile]
#   profile: desktop (default) or server

set -euo pipefail

PROFILE="${1:-desktop}"
DOTFILES_REPO="git@github.com:mtheoryx/dotfiles.git"
DOTFILES_BRANCH="feature/machine-profiles"
DOTFILES_DIR="$HOME/dotfiles"

echo "═══════════════════════════════════════════════════"
echo "  Dotfiles Bootstrap — Ubuntu ($PROFILE profile)"
echo "═══════════════════════════════════════════════════"
echo ""

# ─── System updates ───────────────────────────────────────
echo "→ Updating package lists..."
sudo apt update

echo "→ Upgrading existing packages..."
sudo apt upgrade -y

# ─── Core packages ────────────────────────────────────────
echo "→ Installing core packages..."
sudo apt install -y \
    zsh \
    git \
    stow \
    curl \
    wget \
    unzip \
    build-essential \
    tmux \
    neovim \
    bat \
    eza \
    fzf \
    ripgrep \
    fd-find \
    zoxide

# ─── Desktop extras (skip on server) ─────────────────────
if [[ "$PROFILE" == "desktop" ]]; then
    echo "→ Installing desktop packages..."
    sudo apt install -y \
        yazi
fi

# ─── Set ZSH as default shell ────────────────────────────
if [[ "$SHELL" != "$(which zsh)" ]]; then
    echo "→ Setting zsh as default shell..."
    chsh -s "$(which zsh)"
fi

# ─── Tailscale ────────────────────────────────────────────
if ! command -v tailscale &>/dev/null; then
    echo "→ Installing Tailscale..."
    curl -fsSL https://tailscale.com/install.sh | sh
fi

# ─── Clone dotfiles ───────────────────────────────────────
if [[ ! -d "$DOTFILES_DIR" ]]; then
    echo "→ Cloning dotfiles..."
    git clone -b "$DOTFILES_BRANCH" "$DOTFILES_REPO" "$DOTFILES_DIR"
else
    echo "→ Dotfiles already cloned, pulling latest..."
    cd "$DOTFILES_DIR"
    git fetch && git checkout "$DOTFILES_BRANCH" && git pull
fi

# ─── Stow core packages ──────────────────────────────────
echo "→ Stowing core packages..."
cd "$DOTFILES_DIR"

# Backup existing configs if they exist
for f in ~/.zshrc ~/.zprofile ~/.zshenv; do
    if [[ -f "$f" && ! -L "$f" ]]; then
        echo "  Backing up $f → ${f}.backup"
        mv "$f" "${f}.backup"
    fi
done

# Rename .new files to their real names for stow
# (This is the test — we use the new config)
cp zsh/.zshrc.new zsh/.zshrc.test
cp zsh/.zprofile.new zsh/.zprofile.test

echo ""
echo "═══════════════════════════════════════════════════"
echo "  Bootstrap complete!"
echo "═══════════════════════════════════════════════════"
echo ""
echo "Next steps (manual):"
echo "  1. Review what was installed above"
echo "  2. Set up the dotfiles config:"
echo "     cd ~/dotfiles"
echo "     # Rename .new files to real names:"
echo "     cp zsh/.zshrc.new zsh/.zshrc"
echo "     cp zsh/.zprofile.new zsh/.zprofile"
echo "     cp zsh/.zshenv.new zsh/.zshenv"
echo "     # Stow the zsh package:"
echo "     stow zsh"
echo "     stow tmux"
echo "     stow nvim"
echo "  3. Create ~/.zshrc.secrets with any needed keys"
echo "  4. For server profile, create ~/.zshrc.local with:"
echo "     export DOTFILES_PROFILE=server"
echo "  5. Open a new terminal or run: exec zsh"
echo ""
echo "If anything breaks: exec bash (your backup shell)"
