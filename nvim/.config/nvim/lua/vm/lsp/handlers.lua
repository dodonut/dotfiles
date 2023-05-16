local M = {}

local ok, kind = pcall(require, "lspkind")
if ok then
    kind.init()
end

local has_dap, dap = pcall(require, "dap")
M.setup = function()
    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local config = {
        -- disable virtual text
        virtual_text = true,
        -- show signs
        signs = {
            active = signs,
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
    })
end

local augroup_format = vim.api.nvim_create_augroup("my_lsp_format", { clear = true })
local autocmd_format = function(async, filter)
    vim.api.nvim_clear_autocmds({ buffer = 0, group = augroup_format })
    vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = 0,
        callback = function()
            vim.lsp.buf.formatting({ async = async, filter = filter })
        end,
    })
end

M.filetype_attach = setmetatable({
    java = function(client)
        -- autocmd_format(false)
        if JAVA_DAP_ACTIVE then
            require("jdtls").setup_dap({ hotcodereplace = "auto" })
            require("jdtls.dap").setup_dap_main_class_configs()
            -- vim.lsp.codelens.refresh()
        end
        client.server_capabilities.document_formatting = false
    end,
    go = function()
        local function nnoremap(lhs, rhs, opts)
            vim.api.nvim_buf_set_keymap(0, "n", lhs, rhs, opts)
        end

        if has_dap then
            require("dap-go").setup()
            nnoremap("<leader>dt", '<cmd>lua require("dap-go").debug_test()<cr>', {
                noremap = true,
                silent = true,
            })
            print("Debuggger ready")
        end
    end,
}, {
    __index = function()
        return function() end
    end,
})

M.custom_init = function(client)
    client.config.flags = client.config.flags or {}
    client.config.flags.allow_incremental_sync = true
end

local telescope_mapper = require("vm.telescope.mappings")
M.custom_attach = function(client, bufnr)
    -- Mappings.
    local opts = { noremap = true, silent = true }
    local filetype = vim.api.nvim_buf_get_option(0, "filetype")

    Nnoremap("gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts, bufnr)
    Nnoremap("gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts, bufnr)
    Nnoremap("gl", "<cmd>lua vim.diagnostic.open_float({ border = 'rounded' })<CR>", opts, bufnr)
    Nnoremap("<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts, bufnr)
    Nnoremap("<space>d", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts, bufnr)
    Nnoremap("<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts, bufnr)
    Nnoremap("gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts, bufnr)
    Nnoremap("<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts, bufnr)
    Nnoremap("K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts, bufnr)
    Nnoremap("<F3>", "<cmd> lua vim.lsp.buf.format()<cr>", opts, bufnr)
    Nnoremap("]d", "<cmd> lua vim.diagnostic.goto_prev({ border = 'rounded' })<cr>", opts, bufnr)
    Nnoremap("[d", "<cmd> lua vim.diagnostic.goto_next({ border = 'rounded' })<cr>", opts, bufnr)
    Nnoremap("K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts, bufnr)

    telescope_mapper("gr", "lsp_references", nil, true)
    telescope_mapper("gi", "lsp_implementations", nil, true)
    telescope_mapper("<space>wd", "lsp_document_symbols", { ignore_filename = true }, true)
    telescope_mapper("<space>ww", "lsp_dynamic_workspace_symbols", { ignore_filename = true }, true)

    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.document_highlight then
        local id = vim.api.nvim_create_augroup("lsp_doc_hightlight", { clear = true })
        vim.api.nvim_create_autocmd(
            "CursorHold",
            { pattern = "<buffer>", command = "lua vim.lsp.buf.document_highlight()", group = id }
        )
        vim.api.nvim_create_autocmd(
            "CursorMoved",
            { pattern = "<buffer>", command = "lua vim.lsp.buf.clear_references()", group = id }
        )
    end
    client.server_capabilities.semanticTokensProvider = nil

    -- Attach any filetype specific options to the client
    M.filetype_attach[filetype](client)
end

M.default_capabilities = vim.lsp.protocol.make_client_capabilities()
M.default_capabilities.textDocument.codeLens = { dynamicRegistration = false }
M.default_capabilities.textDocument.completion.completionItem.snippetSupport = true
M.default_capabilities = require("cmp_nvim_lsp").default_capabilities(M.default_capabilities)

function M.enable_format_on_save()
    vim.cmd([[
    augroup format_on_save
      autocmd! 
      autocmd BufWritePre * lua vim.lsp.buf.format({ async = false }) 
    augroup end
  ]] )
    vim.notify("Enabled format on save")
end

function M.disable_format_on_save()
    M.remove_augroup("format_on_save")
    vim.notify("Disabled format on save")
end

function M.toggle_format_on_save()
    if vim.fn.exists("#format_on_save#BufWritePre") == 0 then
        print("enabling auto format")
        M.enable_format_on_save()
    else
        M.disable_format_on_save()
    end
end

function M.remove_augroup(name)
    if vim.fn.exists("#" .. name) == 1 then
        vim.cmd("au! " .. name)
    end
end

vim.cmd([[ command! LspToggleAutoFormat execute 'lua require("vm.lsp.handlers").toggle_format_on_save()' ]])

return M
