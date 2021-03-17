" Plug section
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

" tree
"Plug 'kyazdani42/nvim-web-devicons' " for file icons
"Plug 'kyazdani42/nvim-tree.lua'

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
"Plug 'nanotee/sqls.nvim'

" LSP: 
"Plug 'neovim/nvim-lspconfig'
"Plug 'RishabhRD/nvim-lsputils'
"Plug 'hrsh7th/nvim-compe'
"Plug 'prabirshrestha/vim-lsp'
"Plug 'mattn/vim-lsp-settings'
"Plug 'onsails/lspkind-nvim'
"Plug 'mfussenegger/nvim-jdtls'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" colorschemes
Plug 'christianchiarulli/nvcode-color-schemes.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"" debugger
Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'
call plug#end()

source ~/dotfiles/.config/nvim/plugin/whichkey.vim
source ~/dotfiles/.config/nvim/plugin/signify.vim
source ~/dotfiles/.config/nvim/plugin/cmake.vim
source ~/dotfiles/.config/nvim/plugin/whichkeymapping.vim
source ~/dotfiles/.config/nvim/plugin/colors.vim
source ~/dotfiles/.config/nvim/plugin/fzf.vim
source ~/dotfiles/.config/nvim/plugin/git.vim
source ~/dotfiles/.config/nvim/plugin/nerdcomment.vim
source ~/dotfiles/.config/nvim/plugin/remaps.vim
source ~/dotfiles/.config/nvim/plugin/sets.vim
source ~/dotfiles/.config/nvim/plugin/vimspector.vim
source ~/dotfiles/.config/nvim/plugin/coc.vim


luafile ~/dotfiles/.config/nvim/lua/galaxyline-config.lua
luafile ~/dotfiles/.config/nvim/lua/treesitter-config.lua

function! JavaFormat()
    silent execute("!java -jar ~/jar/google-java-format.jar --replace %:p")
    silent execute("e %")
endfunction

"function! GitPush() 
    ""let branch = execute("silent !git branch --list | grep \\*")
    ""let branch = execute("echon FugitiveStatusline()")
    "let branch = "[Git(feature/loss-551)]"
    "echo branch
    "let out = substitute(branch, "\[Git(\(.+\))\]", "\\1", "g")
    "let tt = substitute(out, ")]", "", "g")

    "echo out " " tt

"endfunction
