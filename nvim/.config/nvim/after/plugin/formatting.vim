function! MyFormatting()
    if expand('%:e') == 'lua'
        silent execute "!stylua %"
        if v:shell_error != 0
            exec lua vim.notify('Fail')
        endif
    else
        silent execute 'lua vim.lsp.buf.formatting_sync()'
    endif
    echo 'Format success!'
endfunction
