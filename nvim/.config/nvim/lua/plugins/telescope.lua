return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                -- NOTE: If you are having trouble with this installation,
                --       refer to the README for telescope-fzf-native for more instructions.
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },

        },
        opts = {
            defaults = {
                prompt_prefix = "❯ ",
                selection_caret = "❯ ",
            },
            extensions = {
                wrap_results = true,

                fzf = {},
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown {},
                },
            },
        },
        keys = function()
            local builtin = require 'telescope.builtin'
            local themes = require 'telescope.themes'
            local noprev_opts = themes.get_dropdown({
                winblend = 10,
                previewer = false,
                shorten_path = false,
                path_display = function(opt, p)
                    local tail = require('telescope.utils').path_tail(p)
                    return string.format("%s - %s", tail, p)
                end,
                file_ignore_patterns = { '%.class' },

                layout_config = {
                    width = 0.5,
                },
            })

            local prev_tail = themes.get_ivy({
                winblend = 10,
                shorten_path = false,
                path_display = function(opt, p)
                    local tail = require('telescope.utils').path_tail(p)
                    return string.format("%s - %s", tail, p)
                end,
                file_ignore_patterns = { '%.class' },

                find_command = { "rg", "--no-ignore", "--files", "--hidden" },
                layout_config = {
                    width = 0.6,
                },
            })

            vim.keymap.set('n', "<leader>fp", function()
                builtin.find_files({
                    cwd = require("lazy.core.config").options.root
                })
            end, { noremap = true, desc = '[TELE] git_files' })

            vim.keymap.set('n', "<c-p>", function()
                builtin.git_files(noprev_opts)
            end, { noremap = true, desc = '[TELE] git_files' })

            vim.keymap.set('n', "<leader>fa", function()
                builtin.find_files(prev_tail)
            end, { noremap = true, desc = '[TELE] find_files' })

            vim.keymap.set('n', "<leader>ff", function()
                builtin.current_buffer_fuzzy_find(themes.get_dropdown({
                    winblend = 10,
                    border = true,
                    previewer = false,
                    shorten_path = false,
                    layout_config = {
                        width = 0.6,
                        height = 0.3
                    }
                }))
            end, { noremap = true, desc = '[TELE] find_files' })

            return {
                { '<leader>fk',      builtin.keymaps,     desc = "[TELE] keymaps" },
                { '<leader>fg',      builtin.live_grep,   desc = "[TELE] live_grep" },
                { '<leader><space>', builtin.buffers,     desc = "[TELE] buffers" },
                { '<leader>fh',      builtin.help_tags,   desc = "[TELE] help_tags" },
                { '<leader>fd',      builtin.diagnostics, desc = "[TELE] diagnostics" },

            }
        end,
        init = function()
            pcall(require("telescope").load_extension, "fzf")
            pcall(require("telescope").load_extension, "ui-select")
        end
    },
}
