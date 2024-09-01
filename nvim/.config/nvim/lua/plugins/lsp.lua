return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "williamboman/mason.nvim",
                config = true,
                opts = {
                    ensure_installed = {
                        "stylua",
                        "shellcheck",
                        "shfmt",
                    }
                }
            },
            {
                "williamboman/mason-lspconfig.nvim",
                init = function()
                    require('mason').setup()
                    local settings = {
                        clangd = {},
                        gopls = {},
                        jdtls = {},
                        cmake = {},
                        lua_ls = {
                            Lua = {
                                workspace = { checkThirdParty = false },
                                telemetry = { enable = false },
                                diagnostics = {
                                    globals = {
                                        "vim",
                                    },
                                },
                            },
                        }
                    }

                    local attach = require("vm.lsp_attach")
                    require('mason-lspconfig').setup({
                        handlers = {
                            function(server_name)
                                require("lspconfig")[server_name].setup({
                                    on_attach = attach.custom_attach,
                                    capabilities = attach.default_capabilities,
                                    settings = settings[server_name]
                                })
                            end,
                            ['jdtls'] = function()
                                require('java').setup()
                                require("lspconfig")['jdtls'].setup({
                                    on_attach = attach.custom_attach,
                                    capabilities = attach.default_capabilities,
                                })
                            end
                        },
                        ensure_installed = settings
                    })
                end
            },
            { "j-hui/fidget.nvim", opts = {} },
            "jose-elias-alvarez/null-ls.nvim"
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
    { 'Bilal2453/luvit-meta', lazy = true },
}
