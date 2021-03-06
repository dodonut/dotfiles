" Plug section
call plug#begin('~/.config/nvim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdcommenter'
Plug 'mbbill/undotree'
Plug 'liuchengxu/vim-which-key'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'
Plug 'sirver/UltiSnips'
Plug 'honza/vim-snippets'
Plug 'sbdchd/neoformat'
Plug 'cdelledonne/vim-cmake'
Plug 'antoinemadec/FixCursorHold.nvim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'christianchiarulli/nvcode-color-schemes.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Debugger Plugins
Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'
call plug#end()

source ~/dotfiles/.config/nvim/plugin/whichkey.vim
source ~/dotfiles/.config/nvim/plugin/cmake.vim
source ~/dotfiles/.config/nvim/plugin/whichkeymapping.vim
source ~/dotfiles/.config/nvim/plugin/coc.vim
source ~/dotfiles/.config/nvim/plugin/colors.vim
source ~/dotfiles/.config/nvim/plugin/fzf.vim
source ~/dotfiles/.config/nvim/plugin/git.vim
source ~/dotfiles/.config/nvim/plugin/nerdcomment.vim
source ~/dotfiles/.config/nvim/plugin/remaps.vim
source ~/dotfiles/.config/nvim/plugin/sets.vim
source ~/dotfiles/.config/nvim/plugin/vimspector.vim



