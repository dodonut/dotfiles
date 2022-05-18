local has_lsp, _ = pcall(require, "lspconfig")
if not has_lsp then
    return
end

-- Can set this lower if needed.
-- require("vim.lsp.log").set_level("debug")
-- require("vim.lsp.log").set_level("trace")

require('vm.lsp.null-ls')
require('vm.lsp.lspinstaller')
require('vm.lsp.handlers').setup()
