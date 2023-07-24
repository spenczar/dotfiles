# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set PATH, MANPATH, etc., for Homebrew.
if [ -f /opt/homebrew/bin/brew ]; then
    export HOMEBREW_PREFIX="/opt/homebrew";
    export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
    export HOMEBREW_REPOSITORY="/opt/homebrew";
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
    export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
    export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
    export PATH="/opt/homebrew/opt/curl/bin:$PATH"
fi

plugins=(git colored-man-pages colorize vagrant z ssh-agent)

export PATH="$PATH:$HOME/bin:$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

source $ZSH/oh-my-zsh.sh

export PROMPT=$'
%{$fg[green]%}%m %{$fg[blue]%}%D{[%Y-%m-%d %H:%M:%S]} %{$reset_color%}%{$fg[white˘]%}[%~]%{$reset_color%} $(git_prompt_info)\
%{$fg[blue]%}$%{$reset_color%} '

export ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}["
export ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
export ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$fg[green]%}"
export ZSH_THEME_GIT_PROMPT_CLEAN=""
export LSCOLORS="Hxfxcxdxbxegedabagacad"

# Connect to an emacs server; start a new one if it's not already set up.
alias ec="emacsclient -nw -a '' -c"
export EDITOR="emacsclient -nw -a '' -c"

# Custom binaries
export PATH="$PATH:$HOME/bin"

# if pyenv is installed, use it
if whence pyenv > /dev/null; then
    export PYENV_ROOT="$HOME/.pyenv"
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    # Virtualenv management
    if whence pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
fi

# Go bins
export PATH=$PATH:$HOME/go/bin

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# Postgres binaries:
export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"

export NVM_DIR="/Users/snelson/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
