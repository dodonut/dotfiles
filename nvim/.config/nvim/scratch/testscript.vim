
let g:dadbods = []
let db = {
        \"name": "Test Postgres DB",
        \"url": "postgresql://postgres:@localhost/postgres"
        \}

call add(g:dadbods, db)

let db = {
        \"name": "test2",
        \"url": "urlzona"
        \}

call add(g:dadbods, db)

let opts = {'title':'Select Database', 'w': 50, 'h':10}

function! OpenMenuDBSelect(list, opts, fun) 
    let i = quickui#listbox#open(map(copy(a:list), {k,v -> v.name}), a:opts)
    let url = a:list[i].url
    call a:fun(url)
endfunction

function! TestFunc(param)

    echo a:param

endfunction

command! Dbteste :call OpenMenuDBSelect(g:dadbods, opts, TestFunc)

