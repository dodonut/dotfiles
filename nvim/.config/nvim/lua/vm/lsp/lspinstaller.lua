local has_lsp, lspinstaller = pcall(require, "nvim-lsp-installer")
if not has_lsp then
    return
end

local handler = require("vm.lsp.handlers")
lspinstaller.on_server_ready(function(server)
    local opts = {
        on_attach = handler.custom_attach,
        capabilities = handler.updated_capabilities,
    }

    if server.name == "lua_ls" then
        local localopts = require("vm.lsp.settings.lua_config")
        opts = vim.tbl_deep_extend("force", localopts, opts)
    end

    if server.name == "jdtls" then
        P('execute?')
        local localopts = require("vm.lsp.settings.jdtls_setup").java_config
        opts = vim.tbl_deep_extend("force", localopts, opts)
    end

    if server.name == "gopls" then
        local localopts = require("vm.lsp.settings.golang")
        opts = vim.tbl_deep_extend("force", localopts, opts)
    end

    -- if server.name == "efm" then
    --     local localopts = require("vm.lsp.settings.efm")
    --     opts = vim.tbl_deep_extend("force", localopts, opts)
    -- end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)
