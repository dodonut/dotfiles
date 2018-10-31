mkdir $HOME/.config/nvim
cp init.vim $HOME/.config/nvim
sudo apt-get update
sudo apt-get install python3-neovim python-neovim -y
cd $HOME/.config/nvim/repos/github.com/junegunn/fzf
./install --all
