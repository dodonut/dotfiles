" Plug section
call plug#begin('~/.config/nvim/plugged')
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-test/vim-test'
Plug 'morhetz/gruvbox'
Plug 'mbbill/undotree'
Plug 'liuchengxu/vim-which-key'
Plug 'ap/vim-css-color'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'christianchiarulli/nvcode-color-schemes.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Debugger Plugins
Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'
call plug#end()


" Config section
let mapleader = ","

" map jk to esc on insert mode
inoremap jk <esc>
" edit ~/.config/nvim/init.vim
map <leader>ev :tabnew ~/dotfiles/.config/nvim/init.vim<cr>
map <leader>sv :source ~/dotfiles/.config/nvim/init.vim<cr>

" close tab or buffer
map <leader>x :close<cr>

" quick save
nnoremap <leader>, :wa<CR>
" nnoremap ; :


" does not work on go files because of vim-go mapping for :GoDef on same key,,
nnoremap <C-t> :tabnew<cr>
source ~/dotfiles/.config/nvim/plugin/whichkey.vim

