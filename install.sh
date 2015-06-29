#!/bin/bash
set -xeo pipefail

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

ln -nsf $DIR/.offlineimaprc ~/.offlineimaprc
ln -nsf $DIR/.gitignore ~/.gitignore
ln -nsf $DIR/.emacs.d/ ~/
ln -nsf $DIR/.zshrc ~/.zshrc 
