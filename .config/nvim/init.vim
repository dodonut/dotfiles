" Plug section
call plug#begin('~/.config/nvim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"Plug 'vim-airline/vim-airline'
Plug 'glepnir/galaxyline.nvim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdcommenter'
Plug 'mbbill/undotree'
Plug 'liuchengxu/vim-which-key'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'
"Plug 'sirver/UltiSnips'
"Plug 'honza/vim-snippets'
Plug 'sbdchd/neoformat'
Plug 'cdelledonne/vim-cmake'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-cheat.sh'

"Plug 'hrsh7th/vim-vsnip'
"Plug 'hrsh7th/vim-vsnip-integ'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

" LSP: 
Plug 'neovim/nvim-lspconfig'
Plug 'onsails/lspkind-nvim'
Plug 'nvim-lua/completion-nvim'
Plug 'hrsh7th/nvim-compe'
"Plug 'euclidianAce/BetterLua.vim'
"Plug 'tjdevries/nlua.nvim'
"Plug 'norcalli/snippets.nvim'
Plug 'mfussenegger/nvim-jdtls'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'glepnir/lspsaga.nvim'
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
"Plug 'nvim-lua/lsp_extensions.nvim'

Plug 'christianchiarulli/nvcode-color-schemes.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'
Plug 'norcalli/snippets.nvim'
call plug#end()


source ~/dotfiles/.config/nvim/plugin/whichkey.vim
source ~/dotfiles/.config/nvim/plugin/vsnip.vim
source ~/dotfiles/.config/nvim/plugin/cmake.vim
source ~/dotfiles/.config/nvim/plugin/whichkeymapping.vim
"source ~/dotfiles/.config/nvim/plugin/coc.vim
source ~/dotfiles/.config/nvim/plugin/colors.vim
source ~/dotfiles/.config/nvim/plugin/fzf.vim
source ~/dotfiles/.config/nvim/plugin/git.vim
source ~/dotfiles/.config/nvim/plugin/nerdcomment.vim
source ~/dotfiles/.config/nvim/plugin/remaps.vim
source ~/dotfiles/.config/nvim/plugin/sets.vim
source ~/dotfiles/.config/nvim/plugin/vimspector.vim


luafile ~/dotfiles/.config/nvim/lua/compe-config.lua
luafile ~/dotfiles/.config/nvim/lua/galaxyline-config.lua
luafile ~/dotfiles/.config/nvim/lua/jsonls.lua
luafile ~/dotfiles/.config/nvim/lua/lsp.lua
luafile ~/dotfiles/.config/nvim/lua/lspkind.lua
luafile ~/dotfiles/.config/nvim/lua/nvimtree-config.lua
luafile ~/dotfiles/.config/nvim/lua/treesitter-config.lua



"function! JavaFormat()
    "silent execute("!java -jar ~/jar/google-java-format.jar --replace %:p", "e %")
"endfunction

"command! -nargs=0 JavaFormat :call JavaFormat()

function! GitPush() 
    "let branch = execute("silent !git branch --list | grep \\*")
    "let branch = execute("echon FugitiveStatusline()")
    let branch = "[Git(feature/loss-551)]"
    echo branch
    let out = substitute(branch, "\[Git(\(.+\))\]", "\\1", "g")
    let tt = substitute(out, ")]", "", "g")

    echo out " " tt

endfunction

command! -nargs=0 GitPush :call GitPush()

"augroup lsp
    "echo 'hereeeeee....'
    "au!
    "au FileType java lua require('java-lsp').setup()
"augroup end
"

