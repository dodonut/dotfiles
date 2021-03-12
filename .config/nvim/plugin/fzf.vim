" fuzzy finding mapping

nnoremap <leader>fc :Commands<cr>
nnoremap <leader>fw :Rg<cr>
nnoremap <leader>fh :RgHidden<cr>
"nnoremap <leader>fw :CocSearch 
nnoremap <leader>fb :Buffers<cr>
nnoremap <leader>fs :Snippets<cr>
nnoremap <leader>fm :Maps<cr>
nnoremap <leader>ff :Files<cr>
nnoremap <leader>fl :Locate 
nnoremap <leader>fr :Rg<cr> 
nnoremap <leader>fq :Plug
" Use K to show documentation in preview window.
nnoremap <C-p> :GFiles<CR>


"Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" Get text in files with Rg
command! -bang -nargs=* RgHidden
  \ call fzf#vim#grep(
  \   'rg --column --hidden --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

let g:fzf_action = {
			\ 'ctrl-t': 'tab split',
			\ 'ctrl-s': 'split',
			\ 'ctrl-v': 'vsplit'
			\}
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--layout=reverse --info=inline'
let $FZF_DEFAULT_COMMAND="rg --files --hidden"

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
