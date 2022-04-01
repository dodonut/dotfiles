#!/bin/bash


alias vc='VimFiles . " > /dev/null"'
alias rn="ranger"
alias luamake='/home/tqi_vsousa/dev/lua-language-server/3rd/luamake/luamake'

export PS1="\[\e[32m\]\w \[\e[91m\]\$(parse_git_branch)\[\e[00m\]$ "
export NVM_DIR="$HOME/.nvm"

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

