return {
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
    {
        -- Adds git releated signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
            on_attach = function(bufnr)
                vim.keymap.set('n', '[g', require('gitsigns').nav_hunk('prev'),
                    { buffer = bufnr, desc = 'Go to Previous Hunk' })
                vim.keymap.set('n', ']g', require('gitsigns').nav_hunc('next'),
                    { buffer = bufnr, desc = 'Go to Next Hunk' })
                vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk,
                    { buffer = bufnr, desc = '[P]review [H]unk' })
            end,
        },
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",  -- required
            "sindrets/diffview.nvim", -- optional - Diff integration
        },
        keys = {
            {
                "<leader>go",
                function()
                    require('neogit').open({ kind = 'split' })
                end,
                desc = '[G]it [O]pen'
            }
        },
        config = true
    }
}
