"|  \/  (_) |                        (_)
"| .  . |_| | _____  ___   _ ____   ___ _ __ ___  _ __ ___
"| |\/| | | |/ / _ \/ __| | '_ \ \ / / | '_ ` _ \| '__/ __|
"| |  | | |   <  __/\__ \ | | | \ V /| | | | | | | | | (__
"\_|  |_/_|_|\_\___||___/ |_| |_|\_/ |_|_| |_| |_|_|  \___|
"
" Author: Mike Hartington
" repo  : https://github.com/mhartington/dotfiles/
"

" Setup dein  ---------------------------------------------------------------{{{
  if (!isdirectory(expand("$HOME/.config/nvim/repos/github.com/Shougo/dein.vim")))
    call system(expand("mkdir -p $HOME/.config/nvim/repos/github.com"))
    call system(expand("git clone https://github.com/Shougo/dein.vim $HOME/.config/nvim/repos/github.com/Shougo/dein.vim"))
endif

  set runtimepath+=~/.config/nvim/repos/github.com/Shougo/dein.vim/
  call dein#begin(expand('~/.config/nvim'))
  call dein#add('Shougo/dein.vim')

" colorscheme & syntax highliting 
  call dein#add('mhartington/oceanic-next')
  call dein#add('Yggdroot/indentLine')
  call dein#add('Raimondi/delimitMate')
  "call dein#add('valloric/MatchTagAlways') "need python

" Git Helpers
  call dein#add('tpope/vim-fugitive')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('Xuyuanp/nerdtree-git-plugin')

" utils
  call dein#add('benekastah/neomake')
  call dein#add('scrooloose/nerdtree')
  call dein#add('bling/vim-airline')
  call dein#add('tpope/vim-surround')
  call dein#add('tomtom/tcomment_vim')
  call dein#add('Chiel92/vim-autoformat')
  call dein#add('gorodinskiy/vim-coloresque')
"Shougo
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neco-vim')
  call dein#add('Shougo/neoinclude.vim')
  call dein#add('Shougo/neosnippet-snippets')
" icons
  call dein#add('ryanoasis/vim-devicons')
  call dein#add('junegunn/fzf', {'dir': '~/.fzf'})
  call dein#add('junegunn/fzf.vim')
  "call dein#add('mattn/gist-vim',{'depends':'mattn/webapi-vim'})

  if dein#check_install()
    call dein#install()
    let pluginsExist=1
  endif

" Required:
  filetype plugin indent on
" }}}
" Neovim Settings
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  set clipboard+=unnamedplus
" Currently need for neovim paste issue
  set pastetoggle=<f6>
" Let airline tell me my status
  set noshowmode
  set noswapfile
  filetype on
  set relativenumber number
  set tabstop=2 shiftwidth=2 expandtab
  "set conceallevel=0
" block selected not limited by shortest line
  set virtualedit=
  set wildmenu
  set laststatus=2
" set colorcolumn=100
  "set wrap linebreak nolist
  "set wildmode=full
" leader is ,
  let mapleader = ','
  set undofile
  set undodir="$HOME/.VIM_UNDO_FILES"
  " Remember cursor position between vim sessions
 autocmd BufReadPost *
             \ if line("'\"") > 0 && line ("'\"") <= line("$") |
             \   exe "normal! g'\"" |
             \ endif
             " center buffer around cursor when opening files
  autocmd BufRead * normal zz
  " set updatetime=500
  set complete=.,w,b,u,t,k
  autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
  autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)
  set formatoptions+=t
  set inccommand=nosplit
  set shortmess=atIc
  set isfname-==
  "set spell
  let g:indentLine_color_gui = '#343d46'
" System mappings---------------------------------------------------------------{{{
" No need for ex mode
  nnoremap Q <nop>
" no recording macros
  map q <nop>
  " Navigate between display lines
  "noremap <silent> <Up> gk 
  "noremap <silent> <Down> gj 
  nnoremap <silent> j gj
  nnoremap <silent> k gk
  " copy current files path to clipboard
  nmap cp :let @+ = expand("%") <cr>
" ,f to format code, require formatters: read the docs
  noremap <leader>f :Autoformat<cr>
  noremap H ^
  noremap L g_
  noremap J 5j
  noremap K 5k

" map : to ; 'cause its easiest
  nnoremap ; :
  inoremap <c-f> <c-x><c-f>
" Copy to clipboard
  vnoremap <C-c> "*y<cr>
  let g:multi_cursor_next_key='<C-n>'
  let g:multi_cursor_prev_key='<C-p>'
  let g:multi_cursor_skip_key='<C-x>'
  let g:multi_cursor_quit_key='<Esc>'

" Align blocks of text and keep them selected
  vmap < <gv
  vmap > >gv
