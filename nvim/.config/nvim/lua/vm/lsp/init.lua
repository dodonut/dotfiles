local has_lsp, lspconfig = pcall(require, "lspconfig")
if not has_lsp then
	return
end

local lspconfig_util = require("lspconfig.util")
local dap = require("dap")
local javadap = require("vm.jdtls_setup").get_dap_config

-- TJ LSPSTATUS
-- local nvim_status = require "lsp-status"

local telescope_mapper = require("vm.telescope.mappings")
-- local handlers = require "vm.lsp.handlers"

-- Can set this lower if needed.
-- require("vim.lsp.log").set_level("debug")
-- require("vim.lsp.log").set_level("trace")

-- local status = require "tj.lsp.status"

-- status.activate()

local custom_init = function(client)
	client.config.flags = client.config.flags or {}
	client.config.flags.allow_incremental_sync = true
end

local filetype_attach = setmetatable({
	go = function(client)
		vim.cmd([[
      augroup lsp_buf_format
        au! BufWritePre <buffer>
        autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()
      augroup END
    ]])
	end,
	java = function(client)
		vim.cmd([[
        augroup jdtls_lsp
            autocmd!
            autocmd FileType java lua require'vm.jdtls_setup'.setup()
        augroup end
        ]])
	end,
}, {
	__index = function()
		return function() end
	end,
})

local custom_attach = function(client, bufnr)
	local function inoremap(lhs, rhs, opts)
		vim.api.nvim_buf_set_keymap(bufnr, "i", lhs, rhs, opts)
	end

	local function nnoremap(lhs, rhs, opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", lhs, rhs, opts)
	end

	-- Mappings.
	local opts = { noremap = true, silent = true }
	local filetype = vim.api.nvim_buf_get_option(0, "filetype")

	inoremap("<c-s>", "<cmd> lua vim.lsp.buf.signature_help<cr> ", opts)
	nnoremap("<space>cr", "<cmd> lua vim.lsp.buf.rename<cr>", opts)
	-- telescope_mapper("<space>ca", "lsp_code_actions", nil, true)
	nnoremap("gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	nnoremap("gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
	nnoremap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	nnoremap("<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	nnoremap("<space>d", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	nnoremap("<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	nnoremap("gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	nnoremap("<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
	nnoremap("K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
	nnoremap("<F3>", "<cmd> call MyFormatting()<cr>", opts)
	inoremap("<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)

	telescope_mapper("gr", "lsp_references", nil, true)
	telescope_mapper("gi", "lsp_implementations", nil, true)
	telescope_mapper("<space>wd", "lsp_document_symbols", { ignore_filename = true }, true)
	telescope_mapper("<space>ww", "lsp_dynamic_workspace_symbols", { ignore_filename = true }, true)

	nnoremap("K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)

	if filetype == "java" then
		require("jdtls").setup_dap({ hotcodereplace = "auto" })
		require("jdtls.dap").setup_dap_main_class_configs()
		require("jdtls.setup").add_commands()
		javadap(function(conf)
			dap.configurations.java = conf
			print("Debugger is ready")
		end)
	end

	vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

	-- Set autocommands conditional on server_capabilities
	if client.resolved_capabilities.document_highlight then
		vim.cmd([[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]])
	end

	if client.resolved_capabilities.code_lens then
		vim.cmd([[
      augroup lsp_document_codelens
        au! * <buffer>
        autocmd BufWritePost,BufEnter <buffer> lua vim.lsp.codelens.refresh()
      augroup END
    ]])
	end

	-- Attach any filetype specific options to the client
	filetype_attach[filetype](client)
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
-- todo see the nvim status
-- updated_capabilities = vim.tbl_deep_extend("keep", updated_capabilities, nvim_status.capabilities)
updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }
updated_capabilities = require("cmp_nvim_lsp").update_capabilities(updated_capabilities)

local servers = {
	vimls = true,
	yamlls = true,
	jsonls = true,
	bashls = true,
	-- cmake = (1 == vim.fn.executable "cmake-language-server"),

	-- clangd = {
	--   cmd = {
	--     "clangd",
	--     "--background-index",
	--     "--suggest-missing-includes",
	--     "--clang-tidy",
	--     "--header-insertion=iwyu",
	--   },
	--   -- Required for lsp-status
	--   init_options = {
	--     clangdFileStatus = true,
	--   },
	--   -- handlers = nvim_status.extensions.clangd.setup(),
	-- },

	-- gopls = {
	--   root_dir = function(fname)
	--     local Path = require "plenary.path"

	--     local absolute_cwd = Path:new(vim.loop.cwd()):absolute()
	--     local absolute_fname = Path:new(fname):absolute()

	--     if string.find(absolute_cwd, "/cmd/", 1, true) and string.find(absolute_fname, absolute_cwd, 1, true) then
	--       return absolute_cwd
	--     end

	--     return lspconfig_util.root_pattern("go.mod", ".git")(fname)
	--   end,

	--   settings = {
	--     gopls = {
	--       codelenses = { test = true },
	--     },
	--   },

	--   flags = {
	--     debounce_text_changes = 200,
	--   },
	-- },

	-- tsserver = {
	--   cmd = { "typescript-language-server", "--stdio" },
	--   filetypes = {
	--     "javascript",
	--     "javascriptreact",
	--     "javascript.jsx",
	--     "typescript",
	--     "typescriptreact",
	--     "typescript.tsx",
	--   },
	-- },
}

local setup_server = function(server, config)
	if not config then
		return
	end

	if type(config) ~= "table" then
		config = {}
	end

	config = vim.tbl_deep_extend("force", {
		on_init = custom_init,
		on_attach = custom_attach,
		capabilities = updated_capabilities,
		flags = {
			debounce_text_changes = 50,
		},
	}, config)

	if server == "jdtls" then
		lspconfig[server].start_or_attach(config)
	else
		lspconfig[server].setup(config)
	end
end

for server, config in pairs(servers) do
	setup_server(server, config)
end

-- Load lua configuration from nlua.
require("nlua.lsp.nvim").setup(lspconfig, {
	on_init = custom_init,
	on_attach = custom_attach,
	capabilities = updated_capabilities,

	globals = {
		-- Custom
		"RELOAD",
	},
})

vim.cmd([[
    augroup jdtls_lsp
        autocmd!
        autocmd FileType java lua require('vm.jdtls_setup').setup()
    augroup end
    ]])

-- this will make efm take place after jdtls
-- since jdtls is not part of lspconfig
vim.schedule(function()
	lspconfig.efm.setup({
		settings = {
			rootMarkers = { ".git" },
			filetypes = {
				"sh",
			},
		},
	})
end)
vim.schedule(function() P(updated_capabilities) end)

return {
	on_init = custom_init,
	on_attach = custom_attach,
	capabilities = updated_capabilities,
}
