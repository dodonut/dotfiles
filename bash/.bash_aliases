#!/bin/bash


alias vc='VimFiles . " > /dev/null"'
alias rn="ranger"
alias luamake='/home/tqi_vsousa/dev/lua-language-server/3rd/luamake/luamake'

export PS1="\[\e[32m\]\w \[\e[91m\]\$(parse_git_branch)\[\e[00m\]$ "
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export JAR=$HOME/dev/jdt/plugins/org.eclipse.equinox.launcher_*.jar
export JDTLS_CONFIG=$HOME/dev/jdt/config_linux
export WORKSPACE=$HOME/workspace
export RANGER_LOAD_DEFAULT_RC=false

export SPRING_PROFILES_ACTIVE=qa
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$(go env GOPATH)/bin

export LD_LIBRARY_PATH=/opt/oracle/instantclient_21_3:$LD_LIBRARY_PATH
export PATH=$HOME/.config/scripts:/opt/oracle/instantclient_21_3:$PATH

