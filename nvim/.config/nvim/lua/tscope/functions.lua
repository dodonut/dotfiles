M = {}

function M.file_browser()
	require("telescope.builtin").file_browser({
		hidden = true,
		prompt = " ~ FileBrowser ~ ",

		layout_strategy = "horizontal",
		layout_options = {
			preview_width = 0.75,
		},
		layout_config = {
			height = 40,
		},
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			},
		},
	})
end

function M.git_files()
	require("telescope.builtin").git_files({
		path_display = function(opts, path)
			local tail = require("telescope.utils").path_tail(path)
			return string.format("%s (%s)", tail, path)
		end,
		prompt = " ~ git files ~ ",

		layout_strategy = "horizontal",
		layout_options = {
			preview_width = 0.75,
		},
		layout_config = {
			height = 40,
		},
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			},
		},
	})
end

function M.find_files()
	require("telescope.builtin").find_files({
		prompt = " ~ all files ~ ",

		layout_strategy = "horizontal",
		layout_options = {
			preview_width = 0.75,
		},
		layout_config = {
			height = 40,
		},
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			},
		},
	})
end

function M.edit_neovim()
	require("telescope.builtin").find_files({
		path_display = { "shorten" },
		cwd = "~/.config/nvim",
		prompt = " ~ dotfiles ~ ",

		layout_strategy = "horizontal",
		layout_options = {
			preview_width = 0.75,
		},
		layout_config = {
			height = 40,
		},
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			},
		},
	})
end

require("telescope").load_extension("fzf")

return M
