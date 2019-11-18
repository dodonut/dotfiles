echo "Updating system"
sudo apt update

# make bash autocompletion to ignore case
if grep -q 'set completion-ignore-case on' $HOME/.inputrc; then 
	echo 'set completion-ignore-case on' >> $HOME/.inputrc
fi

command_exists() {
    type "$1" > /dev/null 2>$1
}

#installing tmux
if ! command_exists tmux; then
    echo "Intalling TMUX..."
    sudo apt install tmux -y
    echo "Done - OK"
fi

#installing neovim
if ! command_exists nvim; then
    echo "Installing NeoVim..."
	https://github.com/neovim/neovim/releases/download/v0.4.3/nvim-linux64.tar.gz
	cd '/tmp' && { curl -L https://github.com/neovim/neovim/releases/download/v0.4.3/nvim-linux64.tar.gz | tar zx; }
	nvimDir = '/tmp/nvim-linux64'
	sudo cp -r $nvimDir/bin /usr/local/
	sudo cp -r $nvimDir/share /usr/local/
    echo "\n\nDone - OK"
else 
    echo "NeoVim already installed."
fi

#creating its directories
if [-d "$HOME/.config/nvim"]; then
    echo "\n\nCreating vim directories"
    mkdir -p $HOME/.config/nvim
    cp init.vim $HOME/.config/nvim
    echo "\n\n Done - OK"
else 
    echo "NeoVim directories already exists... "
fi

echo "Install yarn..."
sudo apt install yarn -y;
echo "Done - OK"

echo "Installing Powerline..."
sudo apt install python-pip python3-pip -y;
sudo pip install powerline-shell -y;
echo '
{
  "segments": [
    "virtual_env", 
    "ssh", 
    "cwd", 
    "git", 
    "hg", 
    "jobs", 
    "root"
  ]
}' > $HOME/.config/powerline-shell/config.json
echo "Done - OK"

#installing vim-plug
if [-d "~/.local/share/nvim/site/autoload/plug.vim"];then
    echo "Installing vim-plug to manage NeoVim plugins"
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

#git
if ! command_exists git; then
	echo "Installing Git..."
	sudo apt install git -y
	echo "Done - OK"
fi


#dev package with all (important) languages
read -p "Want to install all the development package? (y/n)" ans
if [$ans == "y"]; then
	echo "Installing Golang 1.13.4..."
	tmpDir = "/tmp/golang"
	sudo mkdir $tmpDir;
	cd $tmpDir && { curl -O https://dl.google.com/go/go1.13.4.linux-amd64.tar.gz; cd -;}
	echo "\n\nExtracting Golang tar"
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
		echo "Ocurred some unknown error."
	else 
		echo "Done - Ok"
	fi

	echo "Installing Gcc - G++"
	sudo apt install gcc g++ -y
	echo "Done - Ok"
fi


sudo apt update; sudo apt upgrade -y;

# install the plugins automatically
nvim +PlugInstall
