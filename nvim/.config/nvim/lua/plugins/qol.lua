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
    'rafcamlet/nvim-luapad',
    {
        'rcarriga/nvim-notify',
        init = function()
            vim.notify = require('notify')
        end
    }
}
