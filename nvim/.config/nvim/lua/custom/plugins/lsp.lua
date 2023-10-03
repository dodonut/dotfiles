return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim", config = true },
            "williamboman/mason-lspconfig.nvim",
            { "j-hui/fidget.nvim",       branch = 'legacy', opts = {} },
            "folke/neodev.nvim",
            "jose-elias-alvarez/null-ls.nvim"
        },
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-path",
            'hrsh7th/cmp-nvim-lua'
        },
    },
    "mfussenegger/nvim-jdtls",
    'hashivim/vim-terraform',

}
