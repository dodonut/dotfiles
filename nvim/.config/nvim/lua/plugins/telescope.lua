return {
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				-- NOTE If you are having trouble with this installation,
				--       refer to the README for telescope-fzf-native for more instructions.
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
		keys = function()
			local builtin = require("telescope.builtin")
			local themes = require("telescope.themes")
			local noprev_opts = themes.get_dropdown({
				winblend = 10,
				previewer = false,
				shorten_path = false,
				file_ignore_patterns = { "%.class" },

				layout_config = {
					width = 0.5,
				},
			})

			local prev_tail = themes.get_ivy({
				winblend = 10,
				shorten_path = false,
				file_ignore_patterns = { "%.class" },

				find_command = { "rg", "--no-ignore", "--files", "--hidden" },
				layout_config = {
					width = 0.6,
				},
			})

			-- Shortcut for searching your Neovim configuration files
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })

			vim.keymap.set("n", "<leader>sP", function()
				builtin.find_files({ cwd = require("lazy.core.config").options.root })
			end, { noremap = true, desc = "[TELE] [S]earch [P]lugin" })

			vim.keymap.set("n", "<c-p>", function()
				-- builtin.git_files(noprev_opts)
				builtin.find_files(noprev_opts)
			end, { noremap = true, desc = "[TELE] git files" })

			vim.keymap.set("n", "<leader><leader>", function()
				builtin.buffers(noprev_opts)
			end, { noremap = true, desc = "[TELE] search buffers" })

			vim.keymap.set("n", "<leader>sd", function()
				builtin.diagnostics({ severity = "ERROR" })
			end, { noremap = true, desc = "[TELE] [D]iagnostics with error" })

			-- <c-/>
			vim.keymap.set("n", "<c-_>", function()
				builtin.current_buffer_fuzzy_find(themes.get_dropdown({
					winblend = 10,
					border = true,
					previewer = false,
					shorten_path = false,
					layout_config = {
						width = 0.6,
						height = 0.3,
					},
				}))
			end, { noremap = true, desc = "[TELE] [S]earch in [F]ile fuzzy" })

			return {
				{ "<leader>sk", builtin.keymaps, desc = "[TELE] keymaps" },
				{ "<leader>sw", builtin.grep_string, desc = "[TELE] [S]earch current [W]ord" },
				{ "<leader>ss", builtin.lsp_workspace_symbols, desc = "[TELE] [S]earch [S]ymbols" },
				{ "<leader>sg", builtin.live_grep, desc = "[TELE] [S]earch by [G]rep" },
				{ "<leader>sh", builtin.help_tags, desc = "[TELE] [S]earch [H]elptags" },
				{ "<leader>sr", builtin.resume, desc = "[TELE] [S]earch [R]esume" },
				{ "<leader>sD", builtin.diagnostics, desc = "[TELE] [S]earch all [D]iagnostics" },
			}
		end,
		init = function()
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")
			pcall(require("telescope").load_extension("ecolog"))
		end,
		config = function()
			local telescope = require("telescope")
			local telescopeConfig = require("telescope.config")

			-- Clone the default Telescope configuration
			local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

			-- I want to search in hidden/dot files.
			table.insert(vimgrep_arguments, "--hidden")
			-- I don't want to search in the `.git` directory.
			table.insert(vimgrep_arguments, "--glob")
			table.insert(vimgrep_arguments, "!**/.git/*")

			telescope.setup({
				defaults = {
					-- `hidden = true` is not supported in text grep commands.
					vimgrep_arguments = vimgrep_arguments,
					prompt_prefix = "❯ ",
					selection_caret = "❯ ",
					path_display = {
						"filename_first",
					},
				},
				pickers = {
					find_files = {
						-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
						find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
					},
				},
				extensions = {
					wrap_results = true,
					ecolog = {
						shelter = {
							-- Whether to show masked values when copying to clipboard
							mask_on_copy = false,
						},
						-- Default keybindings
						mappings = {
							-- Key to copy value to clipboard
							copy_value = "<C-y>",
							-- Key to copy name to clipboard
							copy_name = "<C-Y>",
							-- Key to edit environment variable
							edit_var = "<C-e>",
						},
					},

					fzf = {},
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
		end,
	},
}
