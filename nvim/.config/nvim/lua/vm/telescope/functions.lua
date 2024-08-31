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
        find_command = { "rg", "--no-ignore", "--files", "--hidden" },
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
M.map_tele = function(key, f, options, _mode, buffer)
    local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

    TelescopeMapArgs[map_key] = options or {}

    local mode = _mode or "n"
    -- local rhs = string.format("<cmd>lua R('vm.telescope.functions')['%s'](TelescopeMapArgs['%s'])<CR>", f, map_key)
    local rhs = string.format("<cmd>lua require('vm.telescope.functions')['%s'](TelescopeMapArgs['%s'])<CR>", f, map_key)

    local map_options = {
        noremap = true,
        silent = true,
        desc = "[TELE] " .. f
    }

    if not buffer then
        vim.api.nvim_set_keymap(mode, key, rhs, map_options)
    else
        vim.api.nvim_buf_set_keymap(0, mode, key, rhs, map_options)
    end
end

return M
