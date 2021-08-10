local M = {}

local on_attach = require("lspconfig").on_attach

function M.setup()
	require("jdtls").start_or_attach({
		cmd = { "java-lsp" },
		on_attach = on_attach,
		root_dir = require("jdtls.setup").find_root({ ".git" }),
	})
end

return M
