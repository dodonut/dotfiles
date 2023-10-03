return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
        }
    },
    -- tree
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
    },
    'rktjmp/highlight-current-n.nvim',
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
    },
    {
        'RishabhRD/nvim-cheat.sh',
        dependencies = {
            'RishabhRD/popfix'
        }
    },
    'rafcamlet/nvim-luapad'
}
