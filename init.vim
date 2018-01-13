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
set rtp+=~/.config/nvim/repos/github.com/junegunn/fzf/
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
"call dein#add('zchee/deoplete-clang')
"call dein#add('tweekmonster/deoplete-clang2')
" icons
" call dein#add('ryanoasis/vim-devicons')
call dein#add('junegunn/fzf', {'dir': '~/.config/nvim/repos/github.com/junegunn/fzf/'})
call dein#add('junegunn/fzf.vim')
"call dein#add('mattn/gist-vim',{'depends':'mattn/webapi-vim'})

if dein#check_install()
  call dein#install()
  let pluginsExist=1
endif

call dein#end()
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
set autowrite
set autoread
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
" go no normal mode with esc in terminal
tnoremap <esc> <C-\><C-n>
map <leader>ev :e! ~/.config/nvim/init.vim<cr>
noremap H ^
noremap L g_
noremap J 5j
noremap K 5k
" goes to beginning and end of line while in insertion mode and keeps in insertion mode
"inoremap <A-l> <esc>$a
"inoremap <A-h> <esc>0i
" make split and tab easier
nnoremap <C-n> :tabnew<cr>
nnoremap <C-i> :tabprevious<cr>
nnoremap <C-o> :tabnext<cr>
nnoremap <C-x> :tabclose<cr>
nnoremap <A-h> :split<cr>
nnoremap <A-v> :vsplit<cr>
" " map : to ; 'cause its easiest
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
"if something is highlited , them just hit escape to get out
map <esc> :noh<cr>

" Themes, Commands, etc---------------------------------------------------------------{{{
" Theme
syntax enable
colorscheme OceanicNext
set background=dark
" Highlight the current line number
hi CursorLineNr guifg=#ffffff
" highlight bad words in red
hi SpellBad guibg=#ff2929 guifg=#ffffff ctermbg=224
" enable deoplete
let g:deoplete#enable_at_startup = 1
" keep term windown open when I navigate away
autocmd TermOpen * set bufhidden=hide
"}}}

" Fold, gets ti's own section---------------------------------------------------------------{{{
  function! MyfoldTest() "{{{
  set foldtext=MyFoldtext()
  autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod
       \ | setlocal foldmethod=manual | endif
  autocmd Insertleave,WinLeave * if exists('w:last_fdm') | let
       \ &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
  set foldlevel=99
" Space to toggle folds.
  nnoremap <Space> za
  vnoremap <Space> za
  autocmd Filetype vim setlocal foldmethod=marker
  autocmd Filetype vim setlocal foldlevel=0
  autocmd Filetype html setlocal foldmethod=marker
  autocmd Filetype html setlocal fdl=3
  autocmd Filetype c,c++ setlocal foldlevel=99
  autocmd Filetype c,c++ setlocal foldmethod=marker
  autocmd Filetype c,c++ setlocal foldmarker={,}
  endfunction
"}}}


"NERDTree ---------------------------------------------------------------{{{
nmap <silent> <leader>k :NERDTreeToggle<CR>
nmap <silent> <leader>y :NERDTreeFind<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeShowHidden=2
let g:NERDTreeQuitOnOpen=1

" NERDTress File highlighting
" function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
" exec 'autocmd FileType nerdtrehighlight ' . a:extension .' ctermbg='. a:fg
" .' guibg='.a:guibg.' guifg='. a:guifg
" exec 'autocmd Filetype nerdtree syn match ' . a:extension . ' #^\s\+.*' .
" a:extension .'$#'
" endfunction
"
" call NERDTreeHighlightFile('c', '#ffa235', 'none', '#f22', 'none' )
" call NERDTreeHighlightFile('cpp', '#25ff21', 'none', '#f22', 'none' )
" call NERDTreeHighlightFile('gitignore', '#ccc', 'none', '#f22', 'none' )
"}}}



"Snippets ---------------------------------------------------------------{{{
" Enable snipMate compatibility feature.
let g:neosnippet#nable_snipmate_compatibility=1
imap <C-k>    <Plug>(neosnippet_expand_or_jump)
smap <C-k>    <Plug>(neosnippet_expand_or_jump)
xmap <C-k>    <Plug>(neosnippet_expand_or_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: "\<TAB>"
"}}}



"FZF ---------------------------------------------------------------{{{
map <leader>t :FZF<cr>
map <leader>r :Buffers<cr>
" search for the selected word on files
vmap <leader>aw y:Ag <c-r>0<cr>


"Navigate between panes ---------------------------------------------------------------{{{

tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" pane resise
tnoremap left :resize -3
" tnoremap <C-j>
" tnoremap <C-k>
" tnoremap <C-l>
" inoremap <C-h>
" inoremap <C-j>
" inoremap <C-k>
" inoremap <C-l>
" nnoremap <C-j>
" nnoremap <C-k>
" nnoremap <C-l>
" nnoremap <C-h>
"}}}


"Airlines ---------------------------------------------------------------{{{
let g:airline_theme='oceanicnext'
"}}}
