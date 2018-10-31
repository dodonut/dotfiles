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
Plug 'roxma/nvim-completion-manager'
" linting
Plug 'w0rp/ale'
" tag pair () [] {}
Plug 'jiangmiao/auto-pairs'
" snippets
Plug 'SirVer/ultisnips'
call plug#end()


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


	
