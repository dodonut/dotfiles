function! MyFormatting()
    if expand('%:e') == 'lua'
        silent execute "!stylua %"
    else
        silent execute 'lua vim.lsp.buf.formatting_sync()'
    endif
    :lua vim.notify("Format Success!")
endfunction
