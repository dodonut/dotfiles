export ZSH="$HOME/.oh-my-zsh"

# ZSH_THEME="agnoster"
ZSH_THEME="robbyrussell"
# ZSH_THEME="apple"
# ZSH_THEME="amuse"


export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true
plugins=(git npm docker docker-compose terraform aws)

source $ZSH/oh-my-zsh.sh


# alias vc="dir=$(pwd); cd ~/.config/nvim; vim; cd $dir;"
alias vc=VimFiles . " > /dev/null"
alias zc="vim ~/.zshrc"
alias rn="ranger"
alias luamake=/home/tqi_vsousa/dev/lua-language-server/3rd/luamake/luamake

function VimFiles() {
    pushd $(pwd) > /dev/null
    cd $HOME/.config/nvim
    vim .;
    popd > /dev/null
}


alias ohmyzsh="vim ~/.oh-my-zsh"


export EDITOR='vim'
# export NVM_DIR="$HOME/.nvm"
# [ -s "$nvm_dir/nvm.sh" ] && \. "$nvm_dir/nvm.sh"  # this loads nvm
# [ -s "$nvm_dir/bash_completion" ] && \. "$nvm_dir/bash_completion"  # this loads nvm bash_completion

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export JAR=$HOME/dev/jdt/plugins/org.eclipse.equinox.launcher_*.jar
export JDTLS_CONFIG=$HOME/dev/jdt/config_linux
export WORKSPACE=$HOME/workspace
export RANGER_LOAD_DEFAULT_RC=false

export SPRING_PROFILES_ACTIVE=qa

export LD_LIBRARY_PATH=/opt/oracle/instantclient_21_3:$LD_LIBRARY_PATH
export PATH=$HOME/.config/scripts:/opt/oracle/instantclient_21_3:$PATH

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/tqi_vsousa/.sdkman"
[[ -s "/home/tqi_vsousa/.sdkman/bin/sdkman-init.sh" ]] && source "/home/tqi_vsousa/.sdkman/bin/sdkman-init.sh"
