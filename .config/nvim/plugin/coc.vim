
"inoremap <silent><expr> <TAB>
			"\ pumvisible() ? coc#_select_confirm():
			"\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
			"\ <SID>check_back_space() ? "\<TAB>" :
			"\ coc#refresh()


"function! s:check_back_space() abort
	"let col = col('.') - 1
	"return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

let g:coc_snippet_next = '<c-l>'

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" autocompletion
let g:coc_global_extensions = ['coc-prettier', 'coc-vimlsp', 'coc-explorer', 'coc-marketplace']

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
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent> <leader>cD  :<C-u>CocList diagnostics<cr>
nmap <leader>ca  <Plug>(coc-codeaction)
nmap <leader>cd <Plug>(coc-definition)
nmap <leader>ct <Plug>(coc-type-definition)
nmap <leader>ci <Plug>(coc-implementation)
nmap <leader>cR <Plug>(coc-references)
nmap <leader>cr <Plug>(coc-rename)
nmap <leader>cq  <Plug>(coc-fix-current)
nnoremap <leader>cf :CocSearch 
nnoremap <leader>cw :CocSearch <C-R>=expand("<cword>")<CR><CR>
imap <C-l> <Plug>(coc-snippets-expand)
