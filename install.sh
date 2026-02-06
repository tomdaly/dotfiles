#!/bin/sh
# symlink dotfiles from this repo to ~/
set -e

DOTFILES="$HOME/dev/dotfiles"

link() {
  src="$DOTFILES/$1"
  dest="$HOME/$1"
  mkdir -p "$(dirname "$dest")"
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    echo "skip (exists): ~/$1"
  else
    ln -sv "$src" "$dest"
  fi
}

# shell
link .zshrc
link .inputrc

# git
link .gitconfig
link .gitignore_global
link .git_hooks_global

# tmux
link .tmux.conf
link .tmux/tmuxline-snapshot-2025-03-05.conf

# terminal
link .config/alacritty/alacritty.toml
link .config/alacritty/themes/kanagawa-wave.toml
link .config/alacritty/themes/kanagawa-dragon.toml

# neovim
ln -sfn "$DOTFILES/nvim" "$HOME/.config/nvim" && echo "linked: ~/.config/nvim" || echo "skip (exists): ~/.config/nvim"

# tools
link .ctags
link .rgignore
link .hammerspoon/init.lua

echo "done. remember to create ~/.zshrc.local and ~/.gitconfig.local"
