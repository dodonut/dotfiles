#.---------- constant part!
#    vvvv vvvv-- the code from above
RED='\033[0;31m'
NC='\033[0m' # No Color

printRed "Updating system"
sudo apt update


# make bash autocompletion to ignore case
if grep -q 'set completion-ignore-case on' $HOME/.inputrc; then 
	printRed 'set completion-ignore-case on' >> $HOME/.inputrc
fi

printRed() {
	printf "${RED}$1${NC}\n"
}

command_exists() {
    type "$1" > /dev/null 2>$1
}

#installing zsh
if ! command_exists zsh; then
	printRed "Installing zsh..."
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	echo "[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh" >> $HOME/.zshrc
	printRed "Done - OK"
fi

#installing tmux
if ! command_exists tmux; then
    printRed "Intalling TMUX..."
    sudo apt install tmux -y
    printRed "Done - OK"
	cp ./tmux/.tmux.conf $HOME/ && mkdir ~/dotfiles && cp -rf ./tmux/tmux_scripts
fi

#installing neovim
if ! command_exists nvim; then
    printRed "Installing NeoVim..."
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && chmod u+x nvim.appimage;
	sudo mv nvim.appimage /usr/bin
	if command_exists zsh; then
		echo "alias vim='nvim.appimage'" >> $HOME/.zshrc
	else 
		echo "alias vim='nvim.appimage'" >> $HOME/.bashrc
	fi

    printRed "\n\nDone - OK"
else 
    printRed "NeoVim already installed."
fi

#creating its directories
if test "$HOME/.config/nvim"; then
    printRed "\n\nCreating vim directories"
    mkdir -p $HOME/.config/nvim
    cp init.vim $HOME/.config/nvim
    printRed "\n\n Done - OK"
else 
    printRed "NeoVim directories already exists... "
fi


#installing vim-plug
if [-d "~/.local/share/nvim/site/autoload/plug.vim"];then
    printRed "Installing vim-plug to manage NeoVim plugins"
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

#git
if ! command_exists git; then
	printRed "Installing Git..."
	sudo apt install git -y
	printRed "Done - OK"
fi


#dev package with all (important) languages
read -p "Want to install all the development package? (y/n)" ans
if [$ans == "y"]; then
	printRed "Installing Golang 1.13.4..."
	tmpDir="/tmp/golang"
	sudo mkdir $tmpDir;
	cd $tmpDir && { curl -O https://dl.google.com/go/go1.13.4.linux-amd64.tar.gz; cd -;}
	printRed "\n\nExtracting Golang tar"
	tar -xvf go*.tar.gz
	sudo mv go /usr/local
	read -p "Want to export Go variables? (y/n)" ans
	if [$ans == "y"]; then
		echo "
			export GOROOT=/usr/local/go;
			export GOBIN=$GOBIN/bin;
			export PATH=$PATH:$GOBIN;
			export GO111MODULE=on;
		" >> $HOME/.profile
		source ~/.profile
	fi
	if ! command_exists go; then
		printRed "Ocurred some unknown error."
	else 
		printRed "Done - Ok"
	fi

	printRed "Installing Gcc - G++"
	sudo apt install gcc g++ -y
	printRed "Done - Ok"

	printRed "Installing NVM/Node LTS"
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
	if ! command_exists nvm; then
		printRed "Failed to run NVM"
	else
		$((nvm install --lts))
	printRed "Done - OK"
fi


sudo apt update; sudo apt upgrade -y;

# install the plugins automatically
printRed "Install VIM plugins"
vim +PlugInstall
