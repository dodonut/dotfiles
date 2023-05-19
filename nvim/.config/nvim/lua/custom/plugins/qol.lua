return {
    { "folke/which-key.nvim", opts = {} },
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
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
    },
}
