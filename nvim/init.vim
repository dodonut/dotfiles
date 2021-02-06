" Plug section
call plug#begin('~/.config/nvim/plugged')
Plug 'honza/vim-snippets'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-test/vim-test'
Plug 'morhetz/gruvbox'

" Debugger Plugins
Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'
call plug#end()


" Config section
let mapleader = ","
set encoding=UTF-8
" mapping for get system clipboard to vim
set clipboard+=unnamedplus


" color for dracula theme
let g:gruvbox_contrast_dark = 'hard'
if exists('+termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection='0'
colorscheme gruvbox
set background=dark

let g:go_auto_sameids = 1
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set number
set relativenumber
set ignorecase
set smartcase
set nohlsearch
set shiftwidth=4
set smartindent
set noswapfile
set nobackup
set tabstop=4 softtabstop=4
set updatetime=50
set shortmess+=c
set scrolloff=8
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

nmap <leader>gs :G<cr>
nmap <leader>gh :diffget //3<cr>

" map jk to esc on insert mode
inoremap jk <esc>

" edit ~/.config/nvim/init.vim
map <leader>ev :tabnew ~/.config/nvim/init.vim<cr>
map <leader>sv :source ~/.config/nvim/init.vim<cr>

" close tab or buffer
map <leader>x :close<cr>

" quick save
nnoremap <leader>, :w<CR>
" nnoremap ; :

nnoremap <leader>k :CocCommand explorer --toggle<cr>

"navigation
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-right> :tabnext<cr>
nnoremap <C-left> :tabprevious<cr>
nnoremap <C-up> :bnext<cr>
nnoremap <C-down> :bprevious<cr>

" does not work on go files because of vim-go mapping for :GoDef on same key,,
nnoremap <C-t> :tabnew<cr>

inoremap <silent><expr> <TAB>
			\ pumvisible() ? coc#_select_confirm():
			\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()


function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

fun GotoWindow(id)
    call win_gotoid(a:id)
    MaximizerToggle
endfun

" Debugger remaps
nnoremap <leader>m :MaximizerToggle!<CR>
nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>dc :call GotoWindow(g:vimspector_session_windows.code)<CR>
nnoremap <leader>dt :call GotoWindow(g:vimspector_session_windows.tagpage)<CR>
nnoremap <leader>dv :call GotoWindow(g:vimspector_session_windows.variables)<CR>
nnoremap <leader>dw :call GotoWindow(g:vimspector_session_windows.watches)<CR>
nnoremap <leader>ds :call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <leader>do :call GotoWindow(g:vimspector_session_windows.output)<CR>
nnoremap <leader>de :call vimspector#Reset()<CR>

let g:vimspector_enable_mappings = 'VISUAL_STUDIO'

let g:coc_snippet_next = '<tab>'

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" autocompletion
 let g:coc_global_extensions = ['coc-prettier', 'coc-tsserver', 'coc-snippets', 'coc-sh', 'coc-go', 'coc-vimlsp', 'coc-explorer']

let g:airline_filetype_overrides = {
  \ 'coc-explorer':  [ 'CoC Explorer', '' ],
  \ 'fugitive': ['fugitive', '%{airline#util#wrap(airline#extensions#branch#get_head(),80)}'],
  \ 'help':  [ 'Help', '%f' ],
  \ }

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')


" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> ]g <Plug>(coc-diagnostic-prev)
nmap <silent> [g <Plug>(coc-diagnostic-next)
nnoremap <silent> <leader>gad  :<C-u>CocList diagnostics<cr>
" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" GoTo code navigation.
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gt <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rr <Plug>(coc-rename)

nnoremap <leader>fa :CocSearch 
nnoremap <leader>sw :CocSearch <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>sf :Rg <C-R>=expand("<cword>")<CR><CR>

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" fuzzy finding mapping
nnoremap <C-g> :FZF<CR>
nnoremap <C-p> :GFiles<CR>
let g:fzf_action = {
			\ 'ctrl-t': 'tab split',
			\ 'ctrl-s': 'split',
			\ 'ctrl-v': 'vsplit'
			\}
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'
let g:fzf_branch_actions = {
			\ 'track': {
			\   'prompt': 'Track> ',
			\   'execute': 'echo system("{git} checkout --track {branch}")',
			\   'multiple': v:false,
			\   'keymap': 'ctrl-t',
			\   'required': ['branch'],
			\   'confirm': v:false,
			\ },
			\}

let g:fzf_preview_window = 'right:60%'





