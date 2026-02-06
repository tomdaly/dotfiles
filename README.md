# dotfiles

macOS dotfiles — zsh, neovim, tmux, alacritty, hammerspoon, git.

## install

```sh
brew install neovim tmux git ripgrep zsh gpg2 gnupg pinentry-mac tree fzf difftastic universal-ctags
git clone git@github.com:tomdaly/dotfiles.git ~/dev/dotfiles
cd ~/dev/dotfiles && sh install.sh
```

`install.sh` symlinks configs into `~/`. it skips files that already exist.

## secrets

secrets and work-specific config live in gitignored `.local` files:

- `~/.zshrc.local` — API tokens, work aliases
- `~/.gitconfig.local` — email, signing key

the public `.zshrc` sources `~/.zshrc.local` at the end, and `.gitconfig` includes `~/.gitconfig.local`.

## structure

```
.zshrc                      → shell config (oh-my-zsh, aliases, PATH)
.tmux.conf                  → tmux config (alacritty colors, vim-tmux-navigator)
.tmux/                      → tmuxline snapshot
.config/alacritty/          → alacritty terminal (toml, kanagawa themes)
.hammerspoon/               → app launcher hotkeys
.gitconfig                  → git config (difftastic, gpg signing)
.gitignore_global           → global gitignore
.git_hooks_global/          → global git hooks (pre-commit)
nvim/                       → neovim config (lua, lazy.nvim, native LSP)
scripts/                    → shell scripts (added to PATH via .zshrc)
.ctags                      → universal-ctags excludes
.inputrc                    → readline vi mode
.rgignore                   → ripgrep ignores
```

## gpg

follow https://gist.github.com/troyfontaine/18c9146295168ee9ca2b30c00bd1b41e

## fonts

install [SauceCodePro Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/SourceCodePro) via homebrew:

```sh
brew install --cask font-sauce-code-pro-nerd-font
```
