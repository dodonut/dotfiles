" LSP config (the mappings used in the default file don't quite work right)
set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

nnoremap gd :lua vim.lsp.buf.definition()<CR>
nnoremap gi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>vs :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>vR :lua vim.lsp.buf.references()<CR>
nnoremap <leader>vr :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>vh :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>va :lua vim.lsp.buf.code_action()<CR>
"nnoremap <leader>vsd :lua vim.lsp.util.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>
"nnoremap <leader>vn :lua vim.lsp.diagnostic.goto_next()<CR>
"nnoremap <leader>vl :lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <space>a :lua vim.lsp.diagnostic.set_loclist()<CR>
