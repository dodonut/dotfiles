SHOULD_RELOAD_TELESCOPE = true

local reloader = function()
	if SHOULD_RELOAD_TELESCOPE then
		RELOAD("plenary")
		RELOAD("popup")
		RELOAD("telescope")
		RELOAD("tj.telescope.setup")
		RELOAD("tj.telescope.custom")
	end
end

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local themes = require("telescope.themes")

local M = {}

function M.edit_neovim()
	local opts_with_preview, opts_without_preview

	opts_with_preview = {
		prompt_title = "~ dotfiles ~",
		shorten_path = false,
		cwd = "~/.config/nvim",

		layout_strategy = "flex",
		layout_config = {
			width = 0.9,
			height = 0.8,

			horizontal = {
				width = { padding = 0.15 },
			},
			vertical = {
				preview_height = 0.75,
			},
		},
	}

	require("telescope.builtin").find_files(opts_with_preview)
end

function M.fd()
	local opts = themes.get_ivy({ hidden = false })
	require("telescope.builtin").fd(opts)
end

function M.builtin()
	require("telescope.builtin").builtin()
end

function M.git_files()
	local path = vim.fn.expand("%:h")
	if path == "" then
		path = nil
	end

	local width = 0.4

	local opts = themes.get_dropdown({
		winblend = 10,
		previewer = false,
		shorten_path = false,
		layout_strategy = "vertical",
		path_display = function(opt, p)
			local tail = require("telescope.utils").path_tail(p)
			return string.format("%s - %s", tail, p)
		end,
		cwd = path,

		layout_config = {
			width = width,
		},
	})

	vim.cmd([[
    silent! !git rev-parse --is-inside-work-tree
  ]])
	if vim.v.shell_error == 0 then
		require("telescope.builtin").git_files(opts)
	else
		require("telescope.builtin").find_files(opts)
	end
end

function M.lsp_code_actions()
	local opts = themes.get_dropdown({
		winblend = 10,
		border = true,
		previewer = false,
		shorten_path = false,
	})

	require("telescope.builtin").lsp_code_actions(opts)
end

function M.live_grep()
	require("telescope.builtin").live_grep({
		-- shorten_path = true,
		previewer = false,
		fzf_separator = "|>",
	})
end

function M.grep_prompt()
	require("telescope.builtin").grep_string({
		path_display = { "shorten" },
		search = vim.fn.input("Grep String > "),
	})
end

function M.grep_last_search(opts)
	opts = opts or {}

	-- \<getreg\>\C
	-- -> Subs out the search things
	local register = vim.fn.getreg("/"):gsub("\\<", ""):gsub("\\>", ""):gsub("\\C", "")

	opts.path_display = { "shorten" }
	opts.word_match = "-w"
	opts.search = register

	require("telescope.builtin").grep_string(opts)
end

function M.installed_plugins()
	require("telescope.builtin").find_files({
		cwd = vim.fn.stdpath("data") .. "/site/pack/packer/start/",
	})
end

function M.project_search()
	require("telescope.builtin").find_files({
		previewer = false,
		layout_strategy = "vertical",
		cwd = require("nvim_lsp.util").root_pattern(".git")(vim.fn.expand("%:p")),
	})
end

function M.buffers()
	require("telescope.builtin").buffers({
		shorten_path = false,
	})
end

function M.curbuf()
	local opts = themes.get_dropdown({
		winblend = 10,
		border = true,
		previewer = false,
		shorten_path = false,
	})
	require("telescope.builtin").current_buffer_fuzzy_find(opts)
end

function M.help_tags()
	require("telescope.builtin").help_tags({
		show_version = true,
	})
end

function M.search_all_files()
	require("telescope.builtin").find_files({
		find_command = { "rg", "--no-ignore", "--files" },
	})
end

function M.file_browser()
	local opts

	opts = {
		sorting_strategy = "ascending",
		scroll_strategy = "cycle",
		layout_config = {
			prompt_position = "top",
		},

		attach_mappings = function(prompt_bufnr, map)
			local current_picker = action_state.get_current_picker(prompt_bufnr)

			local modify_cwd = function(new_cwd)
				current_picker.cwd = new_cwd
				current_picker:refresh(opts.new_finder(new_cwd), { reset_prompt = true })
			end

			map("i", "-", function()
				modify_cwd(current_picker.cwd .. "/..")
			end)

			map("i", "~", function()
				modify_cwd(vim.fn.expand("~"))
			end)

			local modify_depth = function(mod)
				return function()
					opts.depth = opts.depth + mod

					local this_picker = action_state.get_current_picker(prompt_bufnr)
					this_picker:refresh(opts.new_finder(current_picker.cwd), { reset_prompt = true })
				end
			end

			map("i", "<M-=>", modify_depth(1))
			map("i", "<M-+>", modify_depth(-1))

			map("n", "yy", function()
				local entry = action_state.get_selected_entry()
				vim.fn.setreg("+", entry.value)
			end)

			return true
		end,
	}

	require("telescope.builtin").file_browser(opts)
end

function M.lsp_references()
	require("telescope.builtin").lsp_references({
		layout_strategy = "vertical",
		layout_config = {
			prompt_position = "top",
		},
		sorting_strategy = "ascending",
		ignore_filename = false,
	})
end

function M.lsp_implementations()
	require("telescope.builtin").lsp_implementations({
		layout_strategy = "vertical",
		layout_config = {
			prompt_position = "top",
		},
		sorting_strategy = "ascending",
		ignore_filename = false,
	})
end

return setmetatable({}, {
	__index = function(_, k)
		reloader()

		local has_custom, custom = pcall(require, string.format("tj.telescope.custom.%s", k))

		if M[k] then
			return M[k]
		elseif has_custom then
			return custom
		else
			return require("telescope.builtin")[k]
		end
	end,
})
