call plug#begin()
" theme
Plug 'morhetz/gruvbox'
" select multple matches of word to change
Plug 'terryma/vim-multiple-cursors'
" syntax highlight
Plug 'sheerun/vim-polyglot'
" install fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" load fuzzy finder to neovim
Plug 'junegunn/fzf.vim'
" autocomplete (does not work well for c++)
" Plug 'roxma/nvim-completion-manager'
Plug 'prabirshrestha/asyncomplete.vim'
" linting
Plug 'w0rp/ale'
" tag pair () [] {}
Plug 'jiangmiao/auto-pairs'
" autocomplete

Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/neco-vim'
Plug 'Shougo/deoplete-clangx'
Plug 'Shougo/neoinclude.vim'
Plug 'wellle/tmux-complete.vim'

" nerdtree
Plug 'scrooloose/nerdtree'
call plug#end()

autocmd vimenter * NERDTree
colorscheme gruvbox
set background=dark

" let me change load files into memory without saving changes
" but do not let me close vim
set hidden 

" show line number
set number 

" show line relative number
set relativenumber 

" preview matches and changes on regular expressions
" and commands
set inccommand=split  
		     
" leader key
let mapleader="," 

" edit the init.vim file
nnoremap <leader>ev :vsplit ~/.config/nvim/init.vim<cr>
			
" load init.vim on a instance of neovim already
" opened
nnoremap <leader>sv :source ~/.config/nvim/init.vim<cr>

" easier to type ; then : to do commands		
nnoremap ; :
" control + p activates fzf
nnoremap <c-p> :Files<cr>
" control + f activates search word in entire project
nnoremap <c-f> :Ag<space>

noremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

map <leader>k :NERDTreeToggle<CR>
	
