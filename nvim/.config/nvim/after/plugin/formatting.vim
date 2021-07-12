function! MyFormatting()
    if expand('%:e') == 'lua'
        silent execute "!stylua %"
    else
        silent execute 'lua vim.lsp.buf.formatting_seq_sync()'
    endif
endfunction
