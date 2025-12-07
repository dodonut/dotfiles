#!/bin/bash

#update system
cd $HOME
sudo apt update && sudo apt upgrade -y


# install dependencies
sudo apt install xclip ripgrep git unzip zip zsh zoxide stow jq gcc -y

# setup oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#my dotfiles
git clone https://github.com/dodonut/dotfiles.git

#stowing
rm $HOME/.zshrc
cd dotfiles && stow nvim ranger zsh lf scripts && cd $HOME

#zsh plugins
cd $HOME/.oh-my-zsh/custom/plugins
# fast syntax
git clone --depth 1 https://github.com/zdharma-continuum/fast-syntax-highlighting.git

# autosuggestions
git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git

# autocomplete
git clone --depth 1 https://github.com/marlonrichert/zsh-autocomplete.git
cd $HOME

# fzf

if [ ! -d "$HOME/.fzf" ]; then
    echo "installing FZF"
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi



# go installation for lf
cd $HOME/dotfiles/scripts/.config/scripts
chmod +x install-go.sh
./install-go.sh
cd $HOME
env CGO_ENABLED=0 go install -ldflags="-s -w" github.com/gokcehan/lf@latest


if [ ! -d "$HOME/.sdkman" ]; then
    echo "installing sdkman"
    curl -s "https://get.sdkman.io" | bash
    source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

