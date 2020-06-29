#!/bin/sh
# symlink dotfiles
mkdir -p ~/dev/dotfiles
ln -sv ~/dev/dotfiles/.vimrc ~
ln -sv ~/dev/dotfiles/.vim/ ~
ln -sv ~/dev/dotfiles/.tmux.conf ~
