return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                -- NOTE If you are having trouble with this installation,
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
                path_display = {
                    "filename_first"
                },
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
                file_ignore_patterns = { '%.class' },

                layout_config = {
                    width = 0.5,
                },
            })

            local prev_tail = themes.get_ivy({
                winblend = 10,
                shorten_path = false,
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
            end, { noremap = true, desc = '[TELE] find plugins' })

            vim.keymap.set('n', "<c-p>", function()
                builtin.git_files(noprev_opts)
            end, { noremap = true, desc = '[TELE] git_files' })

            vim.keymap.set('n', "<leader>fa", function()
                builtin.find_files(prev_tail)
            end, { noremap = true, desc = '[TELE] find_files' })

            vim.keymap.set('n', "<leader><space>", function()
                builtin.buffers(noprev_opts)
            end, { noremap = true, desc = '[TELE] buffers' })

            vim.keymap.set('n', "<leader>fd", function()
                builtin.diagnostics({
                    severity = "ERROR"
                })
            end, { noremap = true, desc = '[TELE] diagnostics with error' })

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
            end, { noremap = true, desc = '[TELE] fuzzy find in file' })

            return {
                { '<leader>fk', builtin.keymaps,               desc = "[TELE] keymaps" },
                { '<leader>fs', builtin.lsp_workspace_symbols, desc = "[TELE] symbols" },
                { '<leader>fg', builtin.live_grep,             desc = "[TELE] live_grep" },
                { '<leader>fh', builtin.help_tags,             desc = "[TELE] help_tags" },
                { '<leader>fD', builtin.diagnostics,           desc = "[TELE] all diagnostics" },

            }
        end,
        init = function()
            pcall(require("telescope").load_extension, "fzf")
            pcall(require("telescope").load_extension, "ui-select")
        end
    },
}
