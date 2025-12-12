return {
	{
		"folke/which-key.nvim",

		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		opts = {
			triggers = {
				{ "<auto>", mode = "nxso" },
				{ "s", mode = "n" },
			},
			-- delay between pressing a key and opening which-key (milliseconds)
			-- this setting is independent of vim.o.timeoutlen
			delay = 0,
			icons = {
				-- set icon mappings to true if you have a Nerd Font
				mappings = vim.g.have_nerd_font,
				-- If you are using a Nerd Font: set icons.keys to an empty table which will use the
				-- default which-key.nvim defined Nerd Font icons, otherwise define a string table
				keys = vim.g.have_nerd_font and {} or {
					Up = "<Up> ",
					Down = "<Down> ",
					Left = "<Left> ",
					Right = "<Right> ",
					C = "<C-…> ",
					M = "<M-…> ",
					D = "<D-…> ",
					S = "<S-…> ",
					CR = "<CR> ",
					Esc = "<Esc> ",
					ScrollWheelDown = "<ScrollWheelDown> ",
					ScrollWheelUp = "<ScrollWheelUp> ",
					NL = "<NL> ",
					BS = "<BS> ",
					Space = "<Space> ",
					Tab = "<Tab> ",
					F1 = "<F1>",
					F2 = "<F2>",
					F3 = "<F3>",
					F4 = "<F4>",
					F5 = "<F5>",
					F6 = "<F6>",
					F7 = "<F7>",
					F8 = "<F8>",
					F9 = "<F9>",
					F10 = "<F10>",
					F11 = "<F11>",
					F12 = "<F12>",
				},
			},

			spec = {
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>m", group = "[M]ove" },
				{ "<leader>t", group = "[T]oggle" },
				{ "<leader>c", group = "[C]ode" },
				{ "<leader>d", group = "[D]ebug" },
				{ "<leader>g", group = "[G]it" },
				{ "<leader>x", group = "Diagnostics Trouble" },
				{ "<leader>gh", group = "[H]unk" },
				{ "<leader>J", group = "[J]ava" },
				{ "<leader>JT", group = "[T]erminal" },
			},
		},
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
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
	{ "nvim-mini/mini.surround", opts = {} },
	{ "nvim-mini/mini.ai", opts = { n_lines = 500 } },
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
