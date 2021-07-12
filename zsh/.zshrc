export ZSH="/home/usertqi/.oh-my-zsh"

# ZSH_THEME="agnoster"
# ZSH_THEME="robbyrussell"
ZSH_THEME="apple"
# ZSH_THEME="amuse"


plugins=(git aws)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

alias vc="dir=$(pwd); cd ~/.config/nvim; vim; cd $dir;"
alias zc="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

export PATH=$HOME/dev/eclipse/eclipse.jdt.ls/scripts:$PATH

export EDITOR='vim'
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export JAR=$HOME/dev/eclipse/eclipse.jdt.ls/plugins/org.eclipse.equinox.launcher_1.6.200.v20210416-2027.jar
export JDTLS_CONFIG=$HOME/dev/eclipse/eclipse.jdt.ls/config_linux
export WORKSPACE=$HOME/workspace

alias luamake=/home/viniciusmoraes/programming/git-repos/lua-language-server/3rd/luamake/luamake

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/usertqi/.sdkman"
[[ -s "/home/usertqi/.sdkman/bin/sdkman-init.sh" ]] && source "/home/usertqi/.sdkman/bin/sdkman-init.sh"
