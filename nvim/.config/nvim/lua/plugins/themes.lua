return {

    "folke/tokyonight.nvim",
    "navarasu/onedark.nvim",
    {
        "santos-gabriel-dario/darcula-solid.nvim",
        dependencies = { "rktjmp/lush.nvim" }
    },
    {
        "catppuccin/nvim",
        name = "catppuccin"
    },
    {
        -- Set lualine as statusline
        'nvim-lualine/lualine.nvim',
        -- See `:help lualine.txt`
        opts = {
            options = {
                icons_enabled = true,
                component_separators = '|',
                section_separators = '',
            },
        },
    },
}
