return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"jay-babu/mason-nvim-dap.nvim",
			config = function()
				require("mason-nvim-dap").setup()
			end,
		},
		config = function()
			require("mason").setup()
		end,
	},
	{},
	-- {
	-- 	"mfussenegger/nvim-jdtls",
	-- 	dependencies = {
	-- 		"mfussenegger/nvim-dap",
	-- 	},
	-- },
	{
		"neovim/nvim-lspconfig",
		config = function()
			local servers = {
				lua_ls = {
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
				},
				gradle_ls = {},
				bashls = {},
			}
			-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local original_capabilities = vim.lsp.protocol.make_client_capabilities()

			for server, config in pairs(servers) do
				config.capabilities = vim.tbl_deep_extend(
					"force",
					original_capabilities,
					require("blink.cmp").get_lsp_capabilities({}, false)
				)

				vim.lsp.config(server, config)
				vim.lsp.enable(server)
			end
		end,
	},
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
