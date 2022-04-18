
local handlers = require'vm.lsp.handlers'
-- Load lua configuration from nlua.
require("nlua.lsp.nvim").setup(require('lspconfig'), {
	on_init = handlers.custom_init,
	on_attach = handlers.custom_attach,
	capabilities = handlers.updated_capabilities,

	globals = {
		"vim",
		-- Custom
		"RELOAD",
	},
})

return {
		settings = {
			Lua = {
				diagnostics = {
					globals = {
						"vim",
					},
				},
			},
		},
	}
