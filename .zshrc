# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

plugins=(git colored-man colorize vagrant zsh-syntax-highlighting z ssh-agent)

export PATH=$HOME/bin:"/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH=$PATH:$HOME/bin/arcanist/bin:$HOME/go/bin:$HOME/.rvm/bin

source $ZSH/oh-my-zsh.sh

export PROMPT=$'
%{$fg[green]%}%n@%m %{$fg[blue]%}%D{[%I:%M:%S]} %{$reset_color%}%{$fg[white]%}[%~]%{$reset_color%} $(git_prompt_info)\
%{$fg[blue]%}->%{$fg[blue]%} %#%{$reset_color%} '

export ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}["
export ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
export ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$fg[green]%}"
export ZSH_THEME_GIT_PROMPT_CLEAN=""
export LSCOLORS="Hxfxcxdxbxegedabagacad"

# Connect to an emacs server; start a new one if it's not already set up.
alias ec="emacsclient -nw -a '' -c"
export EDITOR="emacsclient -nw -a '' -c"

# Arcanist
alias land="arc land --squash"

# Go:
export GOPATH=$HOME/go
export GOROOT=$HOME/go1.9
export PATH=$PATH:$GOROOT/bin

# Add go binaries:
export PATH=$PATH:/usr/local/opt/go/libexec/bin:$GOPATH/bin
export PATH="$PATH:/usr/local/go/bin"

# Python:
export PATH=$PATH:/Library/Frameworks/Python.framework/Versions/Current/bin
export PYTHONPATH=$HOME/lib/python2.7/site-packages
mkdir -p $PYTHONPATH

# Custom binaries
export PATH="$PATH:$HOME/bin"
# RVM
export PATH="$PATH:$HOME/.rvm/bin"

# Postgres binaries:
export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"

export NVM_DIR="/Users/snelson/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
