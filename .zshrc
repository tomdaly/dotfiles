# If you come from bash you might have to change your $PATH.
# add go binaries to PATH 2022-03-16
export PATH=$PATH:$(go env GOPATH)/bin
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/latest/bin

# https://github.com/ruimarinho/gsts#amazon-ecr 2022-04-07
export PATH=$PATH:$HOME/.docker/bin

# Path to your oh-my-zsh installation.
export ZSH=$HOME"/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="intheloop"
ZSH_THEME="josh"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd" # ISO8601

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git macos z colored-man-pages vi-mode tmux)

VI_MODE_SET_CURSOR=true

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
#
export VISUAL=nvim
export EDITOR="$VISUAL"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
## CUSTOM ALIASES added 2020-04-14
alias v="nvim"
alias ll="ls -laFG"
alias chrome="open -a /Applications/Google\ Chrome.app"
alias fnd="find . -name"
alias t="npm t"

# taskwarrior aliases 2020-12-11
alias in="task add +in"
alias inbox="task in"
alias next="task modify -in +next"

# fix gpg2 pinentry-curses 'inappropriate ioctl for device' error 2020-01-21
export GPG_TTY=$(tty)

# https://tanelpoder.com/posts/how-to-stay-safe-in-shell/ 2021-03-22
set -o noclobber

autoload -U edit-command-line

# lazy load node to improve shell startup time 2022-03-28
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
alias nvm="unalias nvm; [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"; nvm $@"

# magic space for history completion 2023-02-20
# bind Space:magic-space # bash
bindkey " " magic-space # zsh

# m1 arch 2022-03-28
alias abrew="/opt/homebrew/bin/brew"
alias i="arch -x86_64"
alias ibrew="arch -x86_64 /usr/local/bin/brew"
_ARCH=$(arch)
if [[ "$_ARCH" == "i386" ]]; then
 #usr/local is X_86
 alias bundle="arch -x86_64 bundle"
 alias brew="ibrew"
 # export GEM_HOME=$HOME/.gem unset for rvm
 export PATH="/usr/local/bin:$PATH"
 export PATH="/usr/local/opt:$PATH"
 export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
fi
if [[ "$_ARCH" == "arm64" ]]; then
 #usr/local is X_86
 alias brew="abrew"
 # export GEM_HOME=$HOME/.gem unset for rvm
 export PATH=$HOME/.gems/bin:$PATH
 export PATH="/opt/homebrew/bin:$PATH"
 export PATH="/opt/homebrew/opt:$PATH"
 export PATH="/opt/homebrew/opt/curl/bin:$PATH"
 export PATH="/opt/homebrew/opt/imagemagick@6/bin:$PATH"
 export PATH="/opt/homebrew/opt/mysql@5.7/bin:$PATH"
 export LDFLAGS="-L/opt/homebrew/opt/libffi/lib"
 export CPPFLAGS="-I/opt/homebrew/opt/libffi/include"
 export PATH="$(brew --prefix openssl@1.1)/bin:$PATH"
 #export PATH="$(brew --prefix postgresql)/bin:$PATH" # disabled 2023-03-16 to stop 'Use postgresql@14 instead of deprecated postgresql' warning on shell start
 export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(abrew --prefix openssl@1.1)"
 export PKG_CONFIG_PATH="/opt/homebrew/opt/libffi/lib/pkgconfig"
fi

# switch arch 2022-03-30
alias arm="$env /usr/bin/arch -arm64 /bin/zsh --login"
alias intel="$env /usr/bin/arch -x86_64 /bin/zsh --login"

# ruby 2022-03-28
eval "$(rbenv init - zsh)"

# aws alias & region for awscli / gsts 2022-04-07
# idp-id and sp-id need replacing with real values
alias aws-login="gsts --idp-id ABCDEF --sp-id 1234 --force"
export AWS_DEFAULT_REGION="eu-west-1"
export AWS_PROFILE="saml"
function aws-ecr-login() {
  [[ -z $1 ]] && echo "requires account ID as arg 1" && return 1
  aws ecr get-login-password | docker login -u AWS --password-stdin "$1.dkr.ecr.eu-west-1.amazonaws.com"
}

# codecrafters docker course 2022-05-03
alias mydocker="docker build -t mydocker . && docker run --cap-add='SYS_ADMIN' mydocker"

# add RVM to PATH for scripting 2022-07-19
export PATH="$PATH:$HOME/.rvm/bin"

# make fzf ignore .git/node_modules files
export FZF_DEFAULT_COMMAND='rg --files --follow --hidden -g "!{node_modules/*,.git/*}"'
# make fzf remember last search
export FZF_DEFAULT_OPTS="--history=$HOME/.fzf_history"

# gopath default is $HOME/go 2022-11-04

# add custom scripts to path 2023-01-04
export PATH="$PATH:$HOME/dev/dotfiles/scripts"

# ctags alias (brew instead of default mac) 2023-01-04
alias ctags="`brew --prefix`/bin/ctags"

# vim mode for all terminals (mostly rails console) 2023-04-13
bindkey -v

# quick login to aws
alias aws-login="saml2aws login"

# fixes spring tests
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
