

 " navigation
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <leader>v :vs<cr>
nnoremap <leader>h :sp<cr>
nnoremap <c-right> :bnext<cr>
nnoremap <c-left> :bprevious<cr>
nnoremap <right> :tabnext<cr>
nnoremap <left> :tabprevious<cr>
"nnoremap <right> :bnext<cr>
"nnoremap <left> :bprevious<cr>

" close tab or buffer
nnoremap <leader>x :close<cr>

" save file
nnoremap <leader>, :w!<CR>

" greatest remap everrrrrrr
nnoremap : ;
nnoremap ; :

vnoremap : ;
vnoremap ; :

nnoremap <C-n> :tabnew<cr>

nnoremap <leader>sv <cmd>lua require('functions').SourceFiles()<cr>
nnoremap <c-e> 4<c-e>
nnoremap <c-y> 4<c-y>

nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)
