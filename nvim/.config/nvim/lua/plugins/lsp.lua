return {
	{
		"williamboman/mason.nvim",
		config = function()
			-- setup mason with default properties
			require("mason").setup()
		end,
	},
	-- mason nvim dap utilizes mason to automatically ensure debug adapters you want installed are installed, mason-lspconfig will not automatically install debug adapters for us
	{
		"jay-babu/mason-nvim-dap.nvim",
		config = function()
			-- ensure the java debug adapter is installed
			require("mason-nvim-dap").setup({
				-- ensure_installed = { "java-debug-adapter", "java-test" },
			})
		end,
	},
	-- mason lsp config utilizes mason to automatically ensure lsp servers you want installed are installed
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			-- ensure that we have lua language server, typescript launguage server, java language server, and java test language server are installed
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls" },
				automatic_enable = {
					exclude = {
						"jdtls",
					},
				},
			})
		end,
	},
	-- utility plugin for configuring the java language server for us
	-- {
	-- 	"mfussenegger/nvim-jdtls",
	-- 	dependencies = {
	-- 		"mfussenegger/nvim-dap",
	-- 	},
	-- },
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" }, -- <-- Isso remove o erro do vim global
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
						},
					},
				},
				capabilities = capabilities,
			})
		end,
	},
	-- loading progress (primaraly for jdtls)
	{ "j-hui/fidget.nvim", opts = {} },
	"saghen/blink.cmp",
	{
		"nvim-java/nvim-java",
		config = function()
			require("java").setup()

			vim.lsp.config("jdtls", {
				settings = {
					java = {
						configuration = {
							runtimes = {
								{
									name = "JavaSE-1.8",
									path = vim.fn.expand("$HOME/.sdkman/candidates/java/8.*"),
								},
								{
									name = "JavaSE-11",
									path = vim.fn.expand("$HOME/.sdkman/candidates/java/11.*"),
								},
								{
									name = "JavaSE-17",
									path = vim.fn.expand("$HOME/.sdkman/candidates/java/17.*"),
								},
								{
									name = "JavaSE-21",
									path = vim.fn.expand("$HOME/.sdkman/candidates/java/21.*"),
									default = true,
								},
							},
						},
					},
				},
			})

			vim.lsp.enable("jdtls")
		end,
	},
}
