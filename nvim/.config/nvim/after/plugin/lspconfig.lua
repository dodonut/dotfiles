if not pcall(require, "lspconfig") then
	print("LSP not installed")
	return
end

--vim.lsp.set_log_level("debug")
local nvim_lsp = require("lspconfig")
local protocol = require("vim.lsp.protocol")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local function key(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	--Enable completion triggered by <c-x><c-o>
	option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	key("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	key("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
	key("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	key("n", "<space>d", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	key("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	key("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	key("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	-- key("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	key("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
	key("n", "<F3>", "<cmd>call MyFormatting()<cr>", opts)
	--buf_set_keymap('n', '<C-j>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	--buf_set_keymap('n', '<S-C-j>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
	key("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)

	--protocol.SymbolKind = { }
	protocol.CompletionItemKind = {
		"", -- Text
		"", -- Method
		"", -- Function
		"", -- Constructor
		"", -- Field
		"", -- Variable
		"", -- Class
		"ﰮ", -- Interface
		"", -- Module
		"", -- Property
		"", -- Unit
		"", -- Value
		"", -- Enum
		"", -- Keyword
		"﬌", -- Snippet
		"", -- Color
		"", -- File
		"", -- Reference
		"", -- Folder
		"", -- EnumMember
		"", -- Constant
		"", -- Struct
		"", -- Event
		"ﬦ", -- Operator
		"", -- TypeParameter
	}
end

--setup language servers
local _, lspconfig = pcall(require, "lspconfig")
require("lspinstall").setup()

local servers = require("lspinstall").installed_servers()
for _, server in pairs(servers) do
	if server == "lua" then
		lspconfig[server].setup({
			on_attach = on_attach,
			settings = {
				Lua = {
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = { "vim" },
					},
				},
			},
		})
	else
		-- vim.cmd[[nnoremap <leader>= <cmd>lua vim.lsp.buf.formatting_seq_sync()<cr> :w<cr>]]
		lspconfig[server].setup({
			on_attach = on_attach,
		})
	end
end

-- icon
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	-- This sets the spacing and the prefix, obviously.
	virtual_text = {
		spacing = 4,
		prefix = "",
	},
})
