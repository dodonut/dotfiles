#!/bin/bash

#update system
cd "$HOME" || exit
sudo apt update && sudo apt upgrade -y

# install dependencies
sudo apt install bob fd-find npm xclip ripgrep git unzip zip zsh zoxide stow jq gcc tmux -y

# install tmux powerline
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# setup oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#installing bob manager nvim
if ! grep -q 'export .local/bin=' ~/.exports; then
    curl -fsSL https://raw.githubusercontent.com/MordechaiHadad/bob/master/scripts/install.sh | bash
    export PATH="$PATH:$HOME/.local/bin:$HOME/.local/share/bob/nightly/bin" >>"$HOME"/.exports
fi

#stowing
rm "$HOME"/.zshrc
cd dotfiles && stow nvim ranger zsh lf scripts && cd "$HOME" || exit

#zsh plugins
cd "$HOME"/.oh-my-zsh/custom/plugins || exit
# fast syntax
git clone --depth 1 https://github.com/zdharma-continuum/fast-syntax-highlighting.git

# autosuggestions
git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git

# autocomplete
git clone --depth 1 https://github.com/marlonrichert/zsh-autocomplete.git
cd "$HOME" || exit

# fzf

if [ ! -d "$HOME/.fzf" ]; then
    echo "installing FZF"
    git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME"/.fzf
    "$HOME"/.fzf/install
fi

# go installation for lf
cd "$HOME"/dotfiles/scripts/.config/scripts || exit
chmod +x install-go.sh
./install-go.sh
cd "$HOME" || exit
env CGO_ENABLED=0 go install -ldflags="-s -w" github.com/gokcehan/lf@latest

if [ ! -d "$HOME/.sdkman" ]; then
    echo "installing sdkman"
    curl -s "https://get.sdkman.io" | bash
    source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

source "$HOME"/.exports

#installing neovim
bob install nightly
