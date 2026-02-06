# https://github.com/ruimarinho/gsts#amazon-ecr 2022-04-07
export PATH=$PATH:$HOME/.docker/bin

# path to oh-my-zsh installation
export ZSH=$HOME"/.oh-my-zsh"

ZSH_THEME="josh"
HIST_STAMPS="yyyy-mm-dd" # ISO8601 rules!
plugins=(git macos z colored-man-pages vi-mode tmux)

VI_MODE_SET_CURSOR=true

source $ZSH/oh-my-zsh.sh

export VISUAL=nvim
export EDITOR="$VISUAL"

## CUSTOM ALIASES added 2020-04-14
alias v="nvim"
alias ll="ls -laFG"
alias fnd="find . -name"
alias t="npm t"

# mkdir + cd in one command
mkcd () {
  \mkdir -p "$1"
  cd "$1"
}
# change to temp dir
tempe () {
  cd "$(mktemp -d)"
  chmod -R 0700 .
  if [[ $# -eq 1 ]]; then
    \mkdir -p "$1"
    cd "$1"
    chmod -R 0700 .
  fi
}
# make a noise after a command has run
boop () {
  local last="$?"
  if [[ "$last" == '0' ]]; then
    sfx good
  else
    sfx bad
  fi
  $(exit "$last")
}

# fix gpg2 pinentry-curses 'inappropriate ioctl for device' error 2020-01-21
export GPG_TTY=$(tty)

# https://tanelpoder.com/posts/how-to-stay-safe-in-shell/ 2021-03-22
set -o noclobber

autoload -U edit-command-line

# load nvm
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# magic space for history completion 2023-02-20
bindkey " " magic-space # zsh

# aws alias & region for awscli 2022-04-07
export AWS_DEFAULT_REGION="eu-west-1"
export AWS_PROFILE="default"
function aws-ecr-login() {
  [[ -z $1 ]] && echo "requires account ID as arg 1" && return 1
  aws ecr get-login-password | docker login -u AWS --password-stdin "$1.dkr.ecr.eu-west-1.amazonaws.com"
}

# make fzf ignore .git/node_modules files
export FZF_DEFAULT_COMMAND='rg --files --follow --hidden -g "!{node_modules/*,.git/*}"'
# make fzf remember last search
export FZF_DEFAULT_OPTS="-m --history=$HOME/.fzf_history"
# set up fzf
source <(fzf --zsh)

# add custom scripts to path 2023-01-04
export PATH="$PATH:$HOME/dev/dotfiles/scripts"
# add yarn global packages to path 2025-09-25
export PATH="$PATH:$(yarn global bin)"

# ctags alias (brew instead of default mac) 2023-01-04
alias ctags="`brew --prefix`/bin/ctags"

# vim mode for all terminals (mostly rails console) 2023-04-13
bindkey -v

# fixes spring tests
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

alias openssl3="/opt/homebrew/bin/openssl"

# Created by `pipx` on 2025-11-07 12:46:46
export PATH="$PATH:$HOME/.local/bin"

# machine-specific secrets, work aliases, API tokens
source ~/.zshrc.local 2>/dev/null
