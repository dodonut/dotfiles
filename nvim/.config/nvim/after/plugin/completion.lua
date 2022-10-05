if not pcall(require, "lspkind") then
	print("lspking not installed")
	return
end

local lspkind = require("lspkind")
lspkind.init()

-- Setup nvim-cmp.
local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			-- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
		end,
	},
	mapping = {
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<Tab>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
		["<c-q>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
		["<c-n>"] = cmp.mapping.select_next_item(),
		["<c-p>"] = cmp.mapping.select_prev_item(),
		-- ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
	},
	sources = {
		{ name = "buffer", keyword_length = 5 },
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "nvim_lua", ft = { "lua" } },
		{ name = "dap" },
		{ name = "ultisnips" }, -- For ultisnips users.
		{ name = "path" },
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	enabled = function()
		return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
	end,
	experimental = {
		ghost_text = true,
		native_menu = false,
	}, -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
})

-- Add vim-dadbod-completion in sql files
local id = vim.api.nvim_create_augroup("DadbodSql", { clear = true })
vim.api.nvim_create_autocmd(
	"FileType",
	{
		pattern = { "sql", "mysql", "plsql" },
		command = ":lua require('cmp').setup.buffer { sources = { { name = 'vim-dadbod-completion' } } }",
		group = id,
	}
)
