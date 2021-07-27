
function! CtrlP()
    silent! !git rev-parse --is-inside-work-tree
    if v:shell_error == 0
        execute "GFiles"
    else
        execute "Files"
    endif
endfunction


let opt = { 'options':['--info=inline', '--preview', '~/dev/scripts/fzfpreview {}']    }

nnoremap <leader>ev <cmd>call fzf#vim#files('~/.config/nvim', opt)<cr>
nnoremap <leader>fg <cmd>Rg<cr>
nnoremap <leader>fl <cmd>Lines<cr>
nnoremap <leader>fb <cmd>Buffers<cr>
nnoremap <leader>fk <cmd>Maps<cr>
nnoremap <leader>fh <cmd>Helptags<cr>
nnoremap <leader>fc <cmd>Commands<cr>
nnoremap <c-p> <cmd>call CtrlP()<cr>
