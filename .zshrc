export ZSH="/home/viniciusmoraes/.oh-my-zsh"

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

alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"


export EDITOR='vim'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


alias luamake=/home/viniciusmoraes/programming/git-repos/lua-language-server/3rd/luamake/luamake
