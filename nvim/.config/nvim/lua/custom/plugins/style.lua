return {

    "folke/tokyonight.nvim",
    {
        -- Theme inspired by Atom
        "navarasu/onedark.nvim",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("onedark")
        end,
    },
    { "catppuccin/nvim", name = "catppuccin" },
    {
        -- Set lualine as statusline
        'nvim-lualine/lualine.nvim',
        -- See `:help lualine.txt`
        opts = {
            options = {
                icons_enabled = false,
                theme = 'catppuccin',
                component_separators = '|',
                section_separators = '',
            },
        },
    },
    {
        -- Add indentation guides even on blank lines
        "lukas-reineke/indent-blankline.nvim",
        -- Enable `lukas-reineke/indent-blankline.nvim`
        -- See `:help indent_blankline.txt`
        opts = {
            char = "┊",
            show_trailing_blankline_indent = false,
        },
    },
}
