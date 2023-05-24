local has_lsp, mason = pcall(require, "mason")
if not has_lsp then
    return
end

local masonlspconfig = require("mason-lspconfig")
local handler = require("vm.lsp")
mason.setup()
--lua
require('neodev').setup()

local servers = {
    clangd = {},
    gopls = {},
    jdtls = {},
    cmake = {},
    -- java-test = {},
    -- java-debug_adapter = {},
    lua_ls = {
        Lua = {
            workspace = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
            },
            diagnostics = {
                globals = {
                    "vim",
                },
            },
        },
    }
}

masonlspconfig.setup {
    ensure_installed = vim.tbl_keys(servers)
}

masonlspconfig.setup_handlers({
    function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup({
            on_attach = handler.custom_attach,
            capabilities = handler.default_capabilities,
            settings = servers[server_name]
        })
    end,
    jdtls = function() -- make sure that mason does not setup jdtls, and leave to ftplugin/java.lua
    end
})
