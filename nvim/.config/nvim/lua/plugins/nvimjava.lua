return
{
    'nvim-java/nvim-java',
    config = false,
    dependencies = {
        {
            'neovim/nvim-lspconfig',
            opts = {
                servers = {
                    jdtls = {
                        settings = {
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
                                        },
                                    },
                                },
                            },
                        },
                    },
                },
            },
        },
    },
}
