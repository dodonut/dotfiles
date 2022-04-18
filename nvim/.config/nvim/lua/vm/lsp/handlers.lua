local M = {}

M.setup = function ()
    local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end
M.filetype_attach = setmetatable({
	go = function()
		local id = vim.api.nvim_create_augroup("lsp_buf_format_go", { clear = true })
		-- vim.api.nvim_create_autocmd("BufWritePre", {pattern = "*.go", command = ":lua require'functions'.org_imports_go(3000)", group = id})
		vim.api.nvim_create_autocmd(
			"BufWritePre",
			{ pattern = "*.go", command = ":lua vim.lsp.buf.formatting_sync()", group = id }
		)
	end,
}, {
	__index = function()
		return function() end
	end,
})

M.custom_init = function(client)
	client.config.flags = client.config.flags or {}
	client.config.flags.allow_incremental_sync = true
end



local telescope_mapper = require("vm.telescope.mappings")
M.custom_attach = function(client, bufnr)
	local function inoremap(lhs, rhs, opts)
		vim.api.nvim_buf_set_keymap(bufnr, "i", lhs, rhs, opts)
	end

	local function nnoremap(lhs, rhs, opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", lhs, rhs, opts)
	end

	-- Mappings.
	local opts = { noremap = true, silent = true }
	local filetype = vim.api.nvim_buf_get_option(0, "filetype")

	-- telescope_mapper("<space>ca", "lsp_code_actions", nil, true)
	nnoremap("gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	nnoremap("gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
	nnoremap("gl", "<cmd>lua vim.diagnostic.open_float({ border = 'rounded' })<CR>", opts)
	nnoremap("<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	nnoremap("<space>d", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	nnoremap("<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	nnoremap("gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	nnoremap("<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
	nnoremap("K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
	nnoremap("<F3>", "<cmd> lua MyFormatting()<cr>", opts)
	nnoremap("]d", "<cmd> lua vim.diagnostic.goto_prev({ border = 'rounded' })<cr>", opts)
	nnoremap("[d", "<cmd> lua vim.diagnostic.goto_next({ border = 'rounded' })<cr>", opts)
	nnoremap("<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)

	telescope_mapper("gr", "lsp_references", nil, true)
	telescope_mapper("gi", "lsp_implementations", nil, true)
	telescope_mapper("<space>wd", "lsp_document_symbols", { ignore_filename = true }, true)
	telescope_mapper("<space>ww", "lsp_dynamic_workspace_symbols", { ignore_filename = true }, true)

	nnoremap("K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)

	vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

	-- Set autocommands conditional on server_capabilities
	if client.resolved_capabilities.document_highlight then
		local id = vim.api.nvim_create_augroup("lsp_doc_hightlight", { clear = true })
		vim.api.nvim_create_autocmd(
			"CursorHold",
			{ pattern = "<buffer>", command = "lua vim.lsp.buf.document_highlight()", group = id }
		)
		vim.api.nvim_create_autocmd(
			"CursorMoved",
			{ pattern = "<buffer>", command = "lua vim.lsp.buf.clear_references()", group = id }
		)
	end

	if client.resolved_capabilities.code_lens then
		vim.cmd([[
          augroup lsp_document_codelens
            au! * <buffer>
            autocmd BufWritePost,BufEnter <buffer> lua vim.lsp.codelens.refresh()
          augroup END
        ]])
		-- local id = vim.api.nvim_create_augroup("lsp_doc_codelens", {clear = true})
		-- vim.api.nvim_create_autocmd({"BufWritePost", "BufEnter"}, {pattern = "<buffer>", command = ":lua vim.lsp.buf.codelens.refresh()", group = id})
	end

	local has_dap, dap = pcall(require, "dap")
	if has_dap then
		if filetype == "java" then
			require("jdtls").setup_dap({ hotcodereplace = "auto" })
			require("jdtls.dap").setup_dap_main_class_configs()
			require("jdtls.setup").add_commands()
			local javadap = require("vm.jdtls_setup").get_dap_config
			javadap(function(conf)
				dap.configurations.java = conf
				print("Debugger is ready")
			end)
		end
		if filetype == "go" then
			require("dap-go").setup()
			print("Debuggger ready")
		end
	end
	-- Attach any filetype specific options to the client
	M.filetype_attach[filetype](client)
end


M.updated_capabilities = vim.lsp.protocol.make_client_capabilities()
-- todo see the nvim status
-- updated_capabilities = vim.tbl_deep_extend("keep", updated_capabilities, nvim_status.capabilities)
M.updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }
M.updated_capabilities = require("cmp_nvim_lsp").update_capabilities(M.updated_capabilities)

return M
