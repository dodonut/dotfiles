export ZSH="$HOME/.oh-my-zsh"

# ZSH_THEME="agnoster"
# ZSH_THEME="robbyrussell"
ZSH_THEME="apple"
# ZSH_THEME="amuse"


plugins=(git aws gradle-completion)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# alias vc="dir=$(pwd); cd ~/.config/nvim; vim; cd $dir;"
alias vc=VimFiles . " > /dev/null"
alias zc="vim ~/.zshrc"
alias rn="ranger"

function VimFiles() {
    pushd $(pwd) > /dev/null
    cd $HOME/.config/nvim
    vim .;
    popd > /dev/null
}


alias ohmyzsh="vim ~/.oh-my-zsh"

export PATH=$HOME/.config/scripts:$PATH

export EDITOR='vim'
export NVM_DIR="$HOME/.nvm"
[ -s "$nvm_dir/nvm.sh" ] && \. "$nvm_dir/nvm.sh"  # this loads nvm
[ -s "$nvm_dir/bash_completion" ] && \. "$nvm_dir/bash_completion"  # this loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export JAR=$HOME/dev/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_*.jar
export JDTLS_CONFIG=$HOME/dev/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_linux
export WORKSPACE=$HOME/workspace
export RANGER_LOAD_DEFAULT_RC=false

export SPRING_PROFILES_ACTIVE=qa
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias luamake=/home/viniciusmoraes/programming/git-repos/lua-language-server/3rd/luamake/luamake

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/usertqi/.sdkman"
[[ -s "/home/usertqi/.sdkman/bin/sdkman-init.sh" ]] && source "/home/usertqi/.sdkman/bin/sdkman-init.sh"
