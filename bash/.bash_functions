#!/bin/bash
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function VimFiles() {
    pushd $(pwd) > /dev/null
    cd $HOME/.config/nvim
    vim;
    popd > /dev/null
}
