return {
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	{
		-- Adds git releated signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
		config = function()
			require("gitsigns").setup({
				on_attach = function(bufnr)
					local gitsigns = require("gitsigns")

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "[h", function()
						if vim.wo.diff then
							vim.cmd.normal({ "]c", bang = true })
						else
							gitsigns.nav_hunk("next")
						end
					end)

					map("n", "]h", function()
						if vim.wo.diff then
							vim.cmd.normal({ "[c", bang = true })
						else
							gitsigns.nav_hunk("prev")
						end
					end)

					-- Actions
					map("n", "<leader>hP", gitsigns.preview_hunk, { desc = "Git [H]unk [P]review" })
					map("n", "<leader>hp", gitsigns.preview_hunk_inline, { desc = "Git [H]unk [P]review inline" })

					map("n", "<leader>hb", function()
						gitsigns.blame_line({ full = true })
					end, { desc = "Git [H]unk [B]lame" })

					map("n", "<leader>hd", gitsigns.diffthis, { desc = "Git Open [H]unk [D]iff" })

					-- Toggles
					map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
					map("n", "<leader>tw", gitsigns.toggle_word_diff)
				end,
			})
		end,
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
		},
		keys = {
			{
				"<leader>go",
				function()
					require("neogit").open({ kind = "split" })
				end,
				desc = "[G]it [O]pen",
			},
		},
		config = true,
	},
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
	},
}
