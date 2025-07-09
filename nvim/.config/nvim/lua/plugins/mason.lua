return {
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
                cpptools = {},
                debugpy = {},
                gopls = {},
                jdtls = {
                    java = {
                        configuration = {
                            runtimes = {
                                {
                                    name = "JavaSE-11",
                                    path = "$HOME/.sdkman/candidates/java/11.0.12-open",
                                },
                                {
                                    name = "JavaSE-17",
                                    path = "$HOME/.sdkman/candidates/java/17.0.5-oracle",
                                    default = true,
                                },
                            },
                        },
                    },
                },
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

            local attach = require("config.lsp_attach")
            require('mason-lspconfig').setup({
                handlers = {
                    function(server_name)
                        if server_name == 'jdtls' then
                            require('java').setup()
                        end
                        require("lspconfig")[server_name].setup({
                            on_attach = attach.custom_attach,
                            capabilities = attach.default_capabilities,
                            settings = settings[server_name]
                        })
                    end,
                },
                ensure_installed = settings
            })
        end
    },
    {
        'jay-babu/mason-nvim-dap.nvim',
        event = "VeryLazy",
        dependencies = {
            "williamboman/mason.nvim",
            'mfussenegger/nvim-dap',
        },
        opts = {
            handlers = {},
        }
    }
}
