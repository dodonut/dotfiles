if not pcall(require, "lspconfig") then
	return
end

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
	key("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	key("n", "<space>d", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	key("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	key("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	key("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	key("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	key("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
	key("n", "<F3>", "<cmd>call MyFormatting()<cr>", opts)
	key("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)

	key("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
	key("i", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
	key("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
end

--setup language servers
local _, lspconfig = pcall(require, "lspconfig")
require("lspinstall").setup()

local function setup_servers()
	require("lspinstall").setup()
	local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
	local servers = require("lspinstall").installed_servers()
	for _, server in pairs(servers) do
		if server == "lua" then
			lspconfig[server].setup({
				on_attach = on_attach,
				capabilities = capabilities,
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
			lspconfig[server].setup({
				on_attach = on_attach,
			})
		end
	end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require("lspinstall").post_install_hook = function()
	setup_servers() -- reload installed servers
	vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
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
vim.lsp.handlers["textDocument/hover"] = function(_, method, result)
	vim.lsp.util.focusable_float(method, function()
		if not (result and result.contents) then
			vim.notify("No information avalailable")
			return
		end
		local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
		markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
		if vim.tbl_isempty(markdown_lines) then
			-- return { 'No information available' }
			return
		end
		local bufnr, winnr = vim.lsp.util.fancy_floating_markdown(markdown_lines, {
			pad_left = 1,
			pad_right = 1,
		})
		vim.lsp.util.close_preview_autocmd({ "CursorMoved", "BufHidden" }, winnr)
		return bufnr, winnr
	end)
end
return {
	on_attach = on_attach,
}
