# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git colored-man colorize vagrant virtualenv virtualenvwrapper pip python zsh-syntax-highlighting z)

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

source $ZSH/oh-my-zsh.sh

# Connect to an emacs server; start a new one if it's not already set up.
alias ec="emacsclient -a '' -c"

if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='ec'
else
    export EDITOR='nano'
fi

# Arcanist 
alias land="arc land --squash --delete-remote"

# Go:
export GOPATH=/Users/spencer/go
export GOROOT=/usr/local/go
# Add go binaries:
export PATH=$PATH:/usr/local/opt/go/libexec/bin:$GOPATH/bin
export PATH="$PATH:/usr/local/go/bin"

# RVM
export PATH="$PATH:$HOME/.rvm/bin"
