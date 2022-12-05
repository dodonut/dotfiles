local has_lsp, mason = pcall(require, "mason")
if not has_lsp then
    return
end

local lspconfig = require("lspconfig")
local handler = require("vm.lsp.handlers")
mason.setup()
require("mason-lspconfig").setup_handlers({
    function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup({
            on_attach = handler.custom_attach,
            capabilities = handler.default_capabilities,
        })
    end,
    -- Next, you can provide targeted overrides for specific servers.
    ['jdtls'] = function ()
        -- local opts = require('vm.lsp.settings.jdtls_setup').java_config
    end,
    ["sumneko_lua"] = function()
        local settings = require('vm.lsp.settings.lua_config')
        lspconfig.sumneko_lua.setup({
            on_attach = handler.custom_attach,
            capabilities = handler.default_capabilities,
            settings = settings.settings
        })
    end,
})
