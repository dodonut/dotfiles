" fuzzy finding mapping

nnoremap <leader>fc :Commands<cr>
nnoremap <leader>fb :Buffers<cr>
nnoremap <leader>fs :Snippets<cr>
nnoremap <leader>fm :Maps<cr>
nnoremap <leader>ff :FZF<cr>
nnoremap <leader>fl :Locate 
nnoremap <leader>fr :Rg<cr> 

nnoremap <C-p> :GFiles<CR>
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
