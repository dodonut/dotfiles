--
-- local M = {}
-- M.custom_attach = function(_, bufnr)
--   -- Mappings.
--   local nmap = function(keys, func, desc)
--     if desc then
--       desc = "LSP: " .. desc
--     end
--
--     vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
--   end
--
--   nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
--   nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
--
--   nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
--   nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
--   nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
--   nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
--   nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
--   nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
--   nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
--   nmap("K", vim.lsp.buf.hover, "Hover Documentation")
--   nmap("<A-s>", vim.lsp.buf.signature_help, "Signature Documentation")
--
--   vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
--     vim.lsp.buf.format()
--   end, { desc = 'Format current buffer with LSP' })
-- end
--
-- M.default_capabilities = vim.lsp.protocol.make_client_capabilities()
-- M.default_capabilities.textDocument.codeLens = { dynamicRegistration = false }
-- M.default_capabilities.textDocument.completion.completionItem.snippetSupport = true
-- M.default_capabilities = require("cmp_nvim_lsp").default_capabilities(M.default_capabilities)
--
-- return M
--


vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client == nil then
      return
    end

    -- Disable semantic highlights
    client.server_capabilities.semanticTokensProvider = nil

    local opts = { buffer = event.buf }
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', 'gh', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gd', builtin.lsp_definitions, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', builtin.lsp_implementations, opts)
    vim.keymap.set('n', 'gr', builtin.lsp_references, opts)
    vim.keymap.set('n', 'gs', builtin.lsp_workspace_symbols, opts)
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'x' }, '=', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "g]", '<cmd>lua vim.diagnostic.jump({count=1, float=true})<cr>', opts)
    vim.keymap.set("n", "g[", '<cmd>lua vim.diagnostic.jump({count=-1, float=true})<cr>', opts)
  end,
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        disable = {
          "undefined-global",
          "undefined-field"
        }
      },
    }
  }
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'java',
  callback = function(args)
    require 'config.jdtls'.setup()
  end
})
