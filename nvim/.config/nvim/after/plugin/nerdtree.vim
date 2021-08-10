
if !exists(':NERDTree')
    " echo 'NerdTree not installed'
    finish
endif


" nnoremap <leader>K :NERDTreeToggle<cr>
" nnoremap <leader>k :NERDTreeFind<cr>

" let NERDTreeQuitOnOpen=3

" " If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
" autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
"     \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
