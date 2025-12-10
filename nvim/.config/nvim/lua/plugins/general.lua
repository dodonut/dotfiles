return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			spec = {
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>t", group = "[T]oggle" },
				{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
			},
		},
	},
	{
		"RishabhRD/nvim-cheat.sh",
		dependencies = {
			"RishabhRD/popfix",
		},
	},
	"rafcamlet/nvim-luapad",
	{
		"rcarriga/nvim-notify",
		init = function()
			vim.notify = require("notify")
		end,
	},
	"abecodes/tabout.nvim",
	{ "numToStr/Comment.nvim", opts = {} },
	"kylechui/nvim-surround",
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {}, -- empty will call setup
	},

	-- AI chat
	-- {
	-- 	"robitx/gp.nvim",
	-- 	config = function()
	-- 		require("gp").setup()
	-- 	end,
	-- },
}
