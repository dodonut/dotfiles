
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
require'snippets'.use_suggested_mappings(true)

require'lspconfig'.clangd.setup{ capabilities = capabilities }
require'lspconfig'.vimls.setup{ capabilities = capabilities }
--require'lspconfig'.sumneko_lua.setup{ capabilities = capabilities }


