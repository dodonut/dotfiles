
nnoremap <leader>ut :UndotreeToggle<CR> :UndotreeFocus<cr>
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
nnoremap <leader>v :vs<cr>
nnoremap <leader>h :sp<cr>
nnoremap <right> :tabnext<cr>
nnoremap <left> :tabprevious<cr>
nnoremap <up> :bnext<cr>
nnoremap <down> :bprevious<cr>
" Config section
let mapleader = ","

" map jk to esc on insert mode
inoremap jk <esc>
" edit ~/.config/nvim/init.vim
nnoremap <leader>ev :tabnew ~/dotfiles/.config/nvim/init.vim<cr>
nnoremap <leader>sv :source ~/dotfiles/.config/nvim/init.vim<cr>

" close tab or buffer
nnoremap <leader>x :close<cr>

nnoremap <leader>, :w<CR>
nnoremap : ;
nnoremap ; :

" does not work on go files because of vim-go mapping for :GoDef on same key,,
nnoremap <C-t> :tabnew<cr>

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
