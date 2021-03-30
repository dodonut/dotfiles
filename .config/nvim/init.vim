"let g:completion_enable_snippet = 'UltiSnips' Plug section
call plug#begin('~/.config/nvim/plugged')
" fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" status bar
Plug 'glepnir/galaxyline.nvim'
" surround
Plug 'tpope/vim-surround'
" git
Plug 'tpope/vim-fugitive'
" pairs
Plug 'jiangmiao/auto-pairs'
" comments
Plug 'preservim/nerdcommenter'
" undo things
Plug 'mbbill/undotree'
" in case i forget keybindings
Plug 'liuchengxu/vim-which-key'

Plug 'sirver/UltiSnips'
Plug 'honza/vim-snippets'
Plug 'voldikss/vim-floaterm'

" tree
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

" git improvements
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'

" formatting
Plug 'sbdchd/neoformat'

" cmake
Plug 'cdelledonne/vim-cmake'

" cursos
Plug 'antoinemadec/FixCursorHold.nvim'

" cheat sheet
Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-cheat.sh'

" LSP: 
Plug 'neovim/nvim-lspconfig'
Plug 'RishabhRD/nvim-lsputils'
Plug 'hrsh7th/nvim-compe'
"Plug 'nvim-lua/completion-nvim'
Plug 'mattn/vim-lsp-settings'
Plug 'onsails/lspkind-nvim'
Plug 'glepnir/lspsaga.nvim'
Plug 'ray-x/lsp_signature.nvim'
"Plug 'mfussenegger/nvim-jdtls'

"Plug 'neoclide/coc.nvim', {'branch': 'release'}

" colorschemes
Plug 'christianchiarulli/nvcode-color-schemes.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"" debugger
Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'

call plug#end()

source $HOME/.config/nvim/plugin/cmake.vim
source $HOME/.config/nvim/plugin/colors.vim
"source $HOME/.config/nvim/plugin/completion.vim
source $HOME/.config/nvim/plugin/floatterm.vim
source $HOME/.config/nvim/plugin/fzf.vim
source $HOME/.config/nvim/plugin/git.vim
source $HOME/.config/nvim/plugin/lsp.vim
source $HOME/.config/nvim/plugin/nerdcomment.vim
source $HOME/.config/nvim/plugin/remaps.vim
source $HOME/.config/nvim/plugin/sets.vim
source $HOME/.config/nvim/plugin/signify.vim
source $HOME/.config/nvim/plugin/vimspector.vim
source $HOME/.config/nvim/plugin/whichkey.vim
source $HOME/.config/nvim/plugin/whichkeymapping.vim


luafile $HOME/.config/nvim/lua/compe-config.lua
luafile $HOME/.config/nvim/lua/galaxyline-config.lua
luafile $HOME/.config/nvim/lua/jsonls.lua
luafile $HOME/.config/nvim/lua/lsp-kind.lua
luafile $HOME/.config/nvim/lua/lsp-saga.lua
luafile $HOME/.config/nvim/lua/lsp.lua
luafile $HOME/.config/nvim/lua/nvimtree-config.lua
luafile $HOME/.config/nvim/lua/treesitter-config.lua

function! JavaFormat()
    silent execute("!java -jar ~/jar/google-java-format.jar --replace %:p")
    silent execute("e %")
endfunction

augroup fmt_code
    echo "fmt_code"
    autocmd!
    " fmt cpp
    autocmd BufWritePre *.cpp :lua vim.lsp.buf.formatting_sync()
augroup END
