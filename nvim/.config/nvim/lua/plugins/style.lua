return {

    "folke/tokyonight.nvim",
    "navarasu/onedark.nvim",
    { "catppuccin/nvim", name = "catppuccin" },
    {
        -- Set lualine as statusline
        'nvim-lualine/lualine.nvim',
        -- See `:help lualine.txt`
        opts = {
            options = {
                icons_enabled = false,
                theme = 'tokyonight',
                component_separators = '|',
                section_separators = '',
            },
        },
    },
}
