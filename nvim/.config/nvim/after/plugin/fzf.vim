
function! CtrlP()
    silent! !git rev-parse --is-inside-work-tree
    if v:shell_error == 0
        execute "GFiles"
    else
        execute "Files"
    endif
endfunction
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.8, 'relative': v:true, 'yoffset': 1 } }

" uses ctrl-n
" let g:fzf_history_dir = '~/.local/share/fzf-history'

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let opt = { 'options':['--info=inline', '--preview', '~/.config/scripts/fzfpreview {}']    }

nnoremap <leader>ev <cmd>call fzf#vim#files('~/.config/nvim', opt)<cr>
nnoremap <leader>fg <cmd>Rg<cr>
nnoremap <leader>fl <cmd>Lines<cr>
nnoremap <leader>fb <cmd>Buffers<cr>
nnoremap <leader>fk <cmd>Maps<cr>
nnoremap <leader>fh <cmd>Helptags<cr>
nnoremap <leader>fc <cmd>Commands<cr>
nnoremap <leader>fq <cmd>Quickfix<cr>
nnoremap <c-p> <cmd>call CtrlP()<cr>
