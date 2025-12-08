return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function(event)
		-- get access to the none-ls functions
		local null_ls = require("null-ls")
		-- run the setup function for none-ls to setup our different formatters
		null_ls.setup({
			sources = {
				-- setup lua formatter
				null_ls.builtins.formatting.stylua,
                                null_ls.builtins.formatting.shfmt
			},
		})

		-- set up a vim motion for <Space> + c + f to automatically format our code based on which langauge server is active
		vim.keymap.set({ "n", "x" }, "<c-f>", function()
			vim.lsp.buf.format({ bufnr = event.buf })
			vim.cmd("write")
		end, { desc = "format and save" })
	end,
}
