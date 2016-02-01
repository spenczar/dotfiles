#!/bin/bash

# From https://gist.github.com/dpiddy/c4f3d146ae4027a69bc1

# for use with emacs/vim/etc as goimports and goflymake
#
# I use it with config like:
#
# (setenv "GOPATH" (expand-file-name "~/Projects/go"))
# (setenv "PATH" "~/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:~/Projects/go/bin:/usr/local/go/bin")
# (setq exec-path (append exec-path (list (expand-file-name "~/Projects/go/bin") "/usr/local/go/bin")))
#
# and put this script as `goimports` in ~/bin + symlink `goflymake` to it
# with the real `goimports` and `goflymake` in $GOPATH/bin

if [ -z "$GOPATH" ]; then
    echo "Missing GOPATH" >&2
    exit 1
fi

if [[ $GOPATH == *":"* ]]; then
    exit 0
fi

orig_gopath="$GOPATH"

godep_path=$(godep path 2>/dev/null)
if [ $? -eq 0 ]; then
  export GOPATH="$godep_path:$orig_gopath"
fi

exec "$orig_gopath/bin/$(basename "$0")" "$@"
