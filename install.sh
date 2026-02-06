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

linkdir() {
  src="$DOTFILES/$1"
  dest="$HOME/$2"
  mkdir -p "$dest"
  for f in "$src"/*; do
    fname="$(basename "$f")"
    if [ -e "$dest/$fname" ] || [ -L "$dest/$fname" ]; then
      echo "skip (exists): $2/$fname"
    else
      ln -sv "$f" "$dest/$fname"
    fi
  done
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

# claude code
link claude/settings.json .claude/settings.json
link claude/CLAUDE.md .claude/CLAUDE.md
linkdir claude/instructions .claude/instructions
linkdir claude/commands .claude/commands
linkdir claude/shared .claude/shared
for skill_dir in "$DOTFILES"/claude/skills/*/; do
  skill="$(basename "$skill_dir")"
  mkdir -p "$HOME/.claude/skills/$skill"
  if [ -e "$HOME/.claude/skills/$skill/SKILL.md" ] || [ -L "$HOME/.claude/skills/$skill/SKILL.md" ]; then
    echo "skip (exists): .claude/skills/$skill/SKILL.md"
  else
    ln -sv "$skill_dir/SKILL.md" "$HOME/.claude/skills/$skill/SKILL.md"
  fi
done

echo "done. remember to create ~/.zshrc.local and ~/.gitconfig.local"
echo "      also create ~/.claude/instructions/me.private.md and tool-use.private.md"
echo "      (see *.private.example.md for templates)"
