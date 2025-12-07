export ZSH="$HOME/.oh-my-zsh"

source $HOME/.exports

# ZSH_THEME="agnoster"
ZSH_THEME="robbyrussell"
# ZSH_THEME="apple"
# ZSH_THEME="amuse"


export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true
plugins=(git npm docker docker-compose terraform aws   fast-syntax-highlighting zsh-autosuggestions zsh-autocomplete)

source $ZSH/oh-my-zsh.sh


# alias vc="dir=$(pwd); cd ~/.config/nvim; vim; cd $dir;"
alias vc=VimFiles . " > /dev/null"
alias zc="vim ~/.zshrc"
alias rn="ranger"
alias luamake=$HOME/dev/lua-language-server/3rd/luamake/luamake

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



# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

eval "$(zoxide init zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"


