
" if not pcall(require, 'telescope') then
"     print("Telescope Not installed")
"     return
" end

" if !exists(':Telescope')
"     echo 'Telescope not installed'
"     finish
" endif

" function! CtrlP()
"     silent! !git rev-parse --is-inside-work-tree
"     if v:shell_error == 0
"         execute "lua require('tscope.functions').git_files()"
"     else
"         execute "lua require('tscope.functions').find_files()"
"     endif
" endfunction



" nnoremap <leader>ev <cmd>lua require('tscope.functions').edit_neovim()<cr>
" nnoremap <leader>fg <cmd>Telescope live_grep<cr>
" nnoremap <leader>fb <cmd>Telescope buffers<cr>
" nnoremap <leader>fk <cmd>Telescope keymaps<cr>
" nnoremap <leader>fh <cmd>Telescope help_tags<cr>
" nnoremap <leader>fq <cmd>Telescope quickfix<cr>
" nnoremap <leader>fc <cmd>Telescope commands<cr>
" nnoremap <c-p> <cmd>call CtrlP()<cr>

