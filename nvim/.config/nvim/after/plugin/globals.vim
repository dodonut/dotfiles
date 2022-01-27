
command! OpenLspLog :vsplit ~/.cache/nvim/lsp.log

function! OpenMenu(list, opts) 
    let i = quickui#listbox#open(map(copy(a:list), {k,v -> v}), a:opts)
    if i != -1
        let $SPRING_PROFILES_ACTIVE=a:list[i]
    endif
endfunction

let g:prof_list = ['dev', 'qa']
let opts = {'title':'Select the profile', 'w': 50, 'h':10}

command! SetJavaProfile :call OpenMenu(g:prof_list, opts)

nnoremap <leader>sv <cmd>lua require('functions').SourceFiles()<cr>

