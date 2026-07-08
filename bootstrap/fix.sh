#!/usr/bin/env bash
# fix.sh — Pull latest, install missing packages, re-apply config
set -euo pipefail
cd ~/dotfiles
git pull
sudo apt install -y eza
cp zsh/.zshrc.new zsh/.zshrc
cp zsh/.zprofile.new zsh/.zprofile
cp zsh/.zshenv.new zsh/.zshenv
stow -R zsh
echo "export DOTFILES_PROFILE=server" > ~/.zshrc.local
echo "Done. Run: exec zsh"
