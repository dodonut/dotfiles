"" operator mapping
func! DBExe(...)
	if !a:0
		let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
		return 'g@'
	endif
	let sel_save = &selection
	let &selection = "inclusive"
	let reg_save = @@

	if a:1 == 'char'	" Invoked from Visual mode, use gv command.
		silent exe 'normal! gvy'
	elseif a:1 == 'line'
		silent exe "normal! '[V']y"
	else
		silent exe 'normal! `[v`]y'
	endif

	execute "DB " . @@

	let &selection = sel_save
	let @@ = reg_save
endfunction


nnoremap <leader>dt :DBUIToggle<cr>


xnoremap <expr> <Plug>(DBExe)     DBExe()
nnoremap <expr> <Plug>(DBExe)     DBExe()
nnoremap <expr> <Plug>(DBExeLine) DBExe() . '_'

xmap <leader>db  <Plug>(DBExe)
nmap <leader>db  <Plug>(DBExe)
omap <leader>db  <Plug>(DBExe)
nmap <leader>dbb <Plug>(DBExeLine)

" stored locally a credentials file which the function use
" down below is just an example to the format
let g:dadbods = []
let db = {
        \"name": "Test Postgres DB",
        \"url": "postgresql://postgres:@localhost/postgres"
        \}

call add(g:dadbods, db)

" default database
let g:db = g:dadbods[0].url


command! DBSelect :call quickui#listbox#open(map(copy(g:dadbods), {k,v -> v.name}), {
			\"callback": 'DBSelected'
			\})

func! DBSelected(id, result)
	if a:result != -1
		let b:db = g:dadbods[a:result-1].url
		echomsg 'DB ' . g:dadbods[a:result-1].name . ' is selected.'
	endif
endfunc
