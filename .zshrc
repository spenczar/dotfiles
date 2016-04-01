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


# Connect to an emacs server; start a new one if it's not already set up.
alias ec="emacsclient -nw -a '' -c"

if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='ec'
else
    export EDITOR='nano'
fi

# Arcanist
alias land="arc land --squash --delete-remote"

# Go:
export GOPATH=$HOME/go
export PATH=$PATH:$HOME/go1.6/bin
# Add go binaries:
export PATH=$PATH:/usr/local/opt/go/libexec/bin:$GOPATH/bin
export PATH="$PATH:/usr/local/go/bin"

# Custom binaries
export PATH="$PATH:$HOME/bin"
# RVM
export PATH="$PATH:$HOME/.rvm/bin"
