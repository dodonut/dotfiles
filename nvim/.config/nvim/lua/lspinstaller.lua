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

masonlspconfig.setup {
    ensure_installed = vim.tbl_keys(servers)
}

masonlspconfig.setup_handlers({
    function(server_name) -- default handler (optional)
        if server_name ~= 'jdtls' then
            require("lspconfig")[server_name].setup({
                on_attach = handler.custom_attach,
                capabilities = handler.default_capabilities,
                settings = servers[server_name]
            })
        end
    end,
    jdtls = function() end, -- make sure that mason does not setup jdtls, and leave to ftplugin/java.lua
})
