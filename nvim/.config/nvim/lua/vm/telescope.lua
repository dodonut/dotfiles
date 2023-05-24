SHOULD_RELOAD_TELESCOPE = true

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local set_prompt_to_entry_value = function(prompt_bufnr)
    local entry = action_state.get_selected_entry()
    if not entry or not type(entry) == "table" then
        return
    end

    action_state.get_current_picker(prompt_bufnr):reset_prompt(entry.ordinal)
end

require("telescope").setup({
    defaults = {
        prompt_prefix = "❯ ",
        selection_caret = "❯ ",

        winblend = 0,

        layout_strategy = "horizontal",
        layout_config = {
            width = 0.95,
            height = 0.85,
            -- preview_cutoff = 120,
            prompt_position = "top",

            horizontal = {
                preview_width = function(_, cols, _)
                    if cols > 200 then
                        return math.floor(cols * 0.4)
                    else
                        return math.floor(cols * 0.6)
                    end
                end,
            },

            vertical = {
                width = 0.9,
                height = 0.95,
                preview_height = 0.5,
            },

            flex = {
                horizontal = {
                    preview_width = 0.9,
                },
            },
        },

        selection_strategy = "reset",
        sorting_strategy = "descending",
        scroll_strategy = "cycle",
        color_devicons = true,

        mappings = {
            i = {
                ["<C-x>"] = false,
                ["<C-s>"] = actions.select_horizontal,
                ["<C-n>"] = "move_selection_next",
            },
        },

        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },

        -- file_sorter = sorters.get_fzy_sorter,
        file_ignore_patterns = {
            -- "parser.c",
            -- "mock_.*.go",
        },

        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    },

    extensions = {
        fzy_native = {
            override_generic_sorter = true,
            override_file_sorter = true,
        },

        fzf_writer = {
            use_highlighter = false,
            minimum_grep_characters = 6,
        },
    },
})

require("telescope").load_extension("fzf")
local themes = require("telescope.themes")
local utils = require("lspconfig.util")

local M = {}

local width = 0.5
local noprev_opts = themes.get_dropdown({
    winblend = 10,
    previewer = false,
    shorten_path = false,
    layout_strategy = "vertical",
    path_display = function(opt, p)
        local tail = require('telescope.utils').path_tail(p)
        return string.format("%s - %s", tail, p)
    end,
    -- cwd = path,
    file_ignore_patterns = { '%.class' },

    layout_config = {
        width = width,
    },
})

function M.git_files()
    vim.fn.system('git rev-parse --is-inside-work-tree')
    if vim.v.shell_error == 0 then
        require("telescope.builtin").git_files(noprev_opts)
    else
        require("telescope.builtin").find_files(noprev_opts)
    end
end

function M.live_grep()
    require("telescope.builtin").live_grep({
        -- shorten_path = true,
        cwd = utils.root_pattern(".git")(vim.fn.expand("%")) or vim.fn.getcwd(),
        previewer = true,
        fzf_separator = "|>",
        additional_args = function() return { "--hidden" } end
    })
end

function M.project_search()
    require("telescope.builtin").find_files({
        previewer = false,
        layout_strategy = "vertical",
        cwd = utils.root_pattern(".git")(vim.fn.expand("%")) or vim.fn.getcwd(),
    })
end

function M.buffers()
    require("telescope.builtin").buffers(noprev_opts)
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

function M.grep_prompt()
    local text = function()
        vim.cmd('noau normal! "vy"')
        local text = vim.fn.getreg('v')
        vim.fn.setreg('v', {})

        text = string.gsub(text, "\n", "")
        if #text > 0 then
            return text
        else
            return ''
        end
    end

    require("telescope.builtin").grep_string {
        path_display = { "shorten" },
        search = text(),
    }
end

local sorters = require "telescope.sorters"

TelescopeMapArgs = TelescopeMapArgs or {}

-- stole from tj
M.map_tele = function(key, f, options, buffer, mode)
    local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

    TelescopeMapArgs[map_key] = options or {}

    local mode = mode or "n"
    local rhs = string.format("<cmd>lua R('vm.telescope')['%s'](TelescopeMapArgs['%s'])<CR>", f, map_key)

    local map_options = {
        noremap = true,
        silent = true,
    }

    if not buffer then
        vim.api.nvim_set_keymap(mode, key, rhs, map_options)
    else
        vim.api.nvim_buf_set_keymap(0, mode, key, rhs, map_options)
    end
end

local default_opts = { noremap = true, silent = true }
-- Search
M.map_tele("<c-p>", "git_files")
M.map_tele("<leader>fg", "live_grep")
M.map_tele("<leader><space>", "buffers")
M.map_tele("<leader>fa", "search_all_files")
M.map_tele("<leader>ff", "curbuf")
M.map_tele("<leader>fh", "help_tags")
M.map_tele("<leader>fw", "grep_prompt", {
    word_match = "-w",
    short_path = true,
    only_sort_text = true,
    layout_strategy = "vertical",
}, vim.api.nvim_get_current_buf(), "v")
vim.api.nvim_set_keymap("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", default_opts)
vim.api.nvim_set_keymap("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", default_opts)
return M
