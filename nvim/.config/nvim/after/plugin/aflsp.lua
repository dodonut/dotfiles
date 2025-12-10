-- Diagnostic Config
-- See :help vim.diagnostic.Opts
vim.diagnostic.config({
    severity_sort = true,
    float = { border = "rounded", source = "if_many" },
    underline = { severity = vim.diagnostic.severity.ERROR },
    signs = vim.g.have_nerd_font and {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
    } or {},
    virtual_text = {
        source = "if_many",
        spacing = 2,
        format = function(diagnostic)
            local diagnostic_message = {
                [vim.diagnostic.severity.ERROR] = diagnostic.message,
                [vim.diagnostic.severity.WARN] = diagnostic.message,
                [vim.diagnostic.severity.INFO] = diagnostic.message,
                [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
        end,
    },
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client == nil then
            return
        end

        -- Disable semantic highlights
        client.server_capabilities.semanticTokensProvider = nil

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "gh", vim.lsp.buf.hover, { desc = "[g]oto [h]over Documentation'" })
        vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "[g]oto [d]efinition" })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "[g]oto [d]eclaration" })
        vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "[g]oto [i]mplementation" })
        vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "[g]oto [r]eferences" })
        vim.keymap.set("n", "gs", builtin.lsp_workspace_symbols, { desc = "[g]oto [s]ymbols" })
        vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { desc = "refactor rename" })
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[c]ode [a]ctions" })
        vim.keymap.set(
            "n",
            "]d",
            "<cmd>lua vim.diagnostic.jump({count=1, float=true})<cr>",
            { desc = "prev diagnostic" }
        )
        vim.keymap.set(
            "n",
            "[d",
            "<cmd>lua vim.diagnostic.jump({count=-1, float=true})<cr>",
            { desc = "next diagnostic" }
        )

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
                group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
                end,
            })
        end
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    callback = function()
        local jdtls = require("jdtls")
        local root = jdtls.setup.find_root({ "pom.xml", "build.gradle", ".git" })
        if not root then
            return
        end

        -- evita reinicializar o servidor
        if vim.g.jdtls_running_for_root == root then
            return
        end
        vim.g.jdtls_running_for_root = root

        require("config.jdtls").setup_jdtls()
    end,
})
