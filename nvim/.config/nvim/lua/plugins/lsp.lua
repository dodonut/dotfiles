return {
    {
        "neovim/nvim-lspconfig",
        config = function() end, -- dont know why, but its required an EMPTY function for config
        dependencies = {
            { "j-hui/fidget.nvim", opts = {} },
            -- "jose-elias-alvarez/null-ls.nvim",
        },
    },
    -- "mfussenegger/nvim-jdtls",
    'hashivim/vim-terraform',
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = 'luvit-meta/library', words = { 'vim%.uv' } },
            },
        },
    },
    { 'Bilal2453/luvit-meta',   lazy = true },
    {
        "mason-org/mason.nvim",
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        }
    },
    {
        'williamboman/mason-lspconfig.nvim',
        opts = {
            automatic_enable = {
                exclude = {
                    --needs external plugin
                    'jdtls'
                }
            }
        }
    },
    { 'mfussenegger/nvim-jdtls' },
}
