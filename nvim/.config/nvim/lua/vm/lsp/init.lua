local has_lsp, lspconfig = pcall(require, "lspconfig")
if not has_lsp then
	return
end

local has_lsp, lspinstaller = pcall(require, "nvim-lsp-installer")
if not has_lsp then
	return
end


local lspconfig_util = require("lspconfig.util")

local telescope_mapper = require("vm.telescope.mappings")

-- Can set this lower if needed.
-- require("vim.lsp.log").set_level("debug")
-- require("vim.lsp.log").set_level("trace")

local custom_init = function(client)
	client.config.flags = client.config.flags or {}
	client.config.flags.allow_incremental_sync = true
end

local filetype_attach = setmetatable({
	-- go = function(client)
	-- 	vim.cmd([[
	-- augroup lsp_buf_format
	-- au! BufWritePre <buffer>
	-- autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()
	-- augroup END
	-- ]])
	-- end,
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

	local has_dap, dap = pcall(require, "dap")
	if has_lsp then
		if filetype == "java" then
			require("jdtls").setup_dap({ hotcodereplace = "auto" })
			require("jdtls.dap").setup_dap_main_class_configs()
			require("jdtls.setup").add_commands()
			javadap(function(conf)
				dap.configurations.java = conf
				print("Debugger is ready")
			end)
		end
	    if filetype == "go" then
		require('dap-go').setup()
		print('Debuggger ready')
	    end
	end
	-- Attach any filetype specific options to the client
        filetype_attach[filetype](client)

        vim.cmd([[
          augroup lsp_buf_format
            au! BufWritePre <buffer>
            autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()
          augroup END
        ]])
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
-- todo see the nvim status
-- updated_capabilities = vim.tbl_deep_extend("keep", updated_capabilities, nvim_status.capabilities)
updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }
updated_capabilities = require("cmp_nvim_lsp").update_capabilities(updated_capabilities)

local util = require("lspconfig.util")
local root_dir = function(fname)
	return util.root_pattern(".git")(fname) or vim.fn.getcwd()
end

local java_config = {
	java = {
		referencesCodelens = {
			enable = true,
		},
		implementationCodelens = {
			enable = true,
		},
	},
}
local bundles = {
	-- https://github.com/microsoft/java-debug
	vim.fn.glob(
		"$HOME/dev/source-proj/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
	),
}

--https://github.com/microsoft/vscode-java-test
vim.list_extend(bundles, vim.split(vim.fn.glob("$HOME/dev/source-proj/vscode-java-test/server/*.jar"), "\n"))

--local extendedClientCapabilities = require("jdtls").extendedClientCapabilities
--extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
--java_config.init_options = {
--	bundles = bundles,
--	extendedClientCapabilities = extendedClientCapabilities,
--}

local servers = {
	terraformls = true,
	tflint = true,
	bashls = true,
	groovyls = {
		settings = {
			root_dir = root_dir,
		},
	},
	vimls = true,
	yamlls = true,
	jsonls = true,
	jdtls = java_config,
	efm = {
		settings = {
			root_dir = root_dir,
			languages = {
				sh = {
					lintCommand = "shellcheck -f gcc -x -",
					lintStdin = true,
					lintFormats = { "%f=%l:%c: %trror: %m", "%f=%l:%c: %tarning: %m", "%f=%l:%c: %tote: %m" },
				},
			},
			filetypes = { "sh" },
			-- cmd = {"efm-langserver", "-c", "~/.config/efm-langserver/config.yaml"}
		},
	},
	sumneko_lua = {
		settings = {
			Lua = {
				diagnostics = {
					globals = {
						"vim",
					},
				},
			},
		},
	},
	gopls = {
		settings = {
			gopls = {
				codelenses = { test = true },
			},
		},

		flags = {
			debounce_text_changes = 200,
		},
	},
}

local setup_server = function(server_name, config)
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
	-- config.on_init = function(_, _)
	-- 	vim.notify("workspace/didChangeConfiguration", { settings = config.settings })
	-- end

	-- from the manual to automatic
	-- lspinstaller[server].setup(config)
	local server_available, server = lspinstaller.get_server(server_name)
	if server_available then
		server:on_ready(function()
			server:setup(config)
		end)
		if not server:is_installed() then
			-- Queue the server to be installed.
			print("installing server " .. server_name)
			server:install()
		end
	else
		print("Not available", server_name)
	end
end

for server, config in pairs(servers) do
	setup_server(server, config)
end

return {
	on_init = custom_init,
	on_attach = custom_attach,
	capabilities = updated_capabilities,
}
