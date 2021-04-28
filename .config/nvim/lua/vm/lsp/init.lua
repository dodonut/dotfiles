local has_lsp, lspconfig = pcall(require, 'lspconfig')

require('vim.lsp.log').set_level("debug")
-- require('vim.lsp.log').set_level("trace")

_ = require('lspkind').init()

require('vm.lsp.status').activate()
require('vm.lsp.handlers')

local on_attach = function(client, bufnr)
    if lsp_status ~= nil then
      lspconfig.on_attach(client, bufnr)
    end
    require "lsp_signature".on_attach()  -- Note: add in lsp client on-attach
end


require'lspinstall'.setup()
local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
    lspconfig[server].setup{
        on_attach = on_attach
    }
end
require'lsp_signature'.on_attach()
