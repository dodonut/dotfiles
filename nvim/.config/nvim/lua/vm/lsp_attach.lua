local M = {}

M.filetype_attach = setmetatable({
  java = function(client)
    vim.keymap.set('n', "<leader>jto", "<cmd>JavaTestViewLastReport<cr>",
      { noremap = true, desc = "[J]ava [T]est [O]pen last report" })

    vim.keymap.set('n', "<leader>jdc", "<cmd>JavaTestDebugCurrentMethod<cr>",
      { noremap = true, desc = "[J]ava [D]ebug [C]urrent method" })

    vim.keymap.set('n', "<leader>jrt", "<cmd>JavaTestRunCurrentClass<cr>",
      { noremap = true, desc = "[J]ava [R]un class [T]ests" })
  end,
}, {
  __index = function()
    return function()
    end
  end,
})

M.custom_attach = function(client, bufnr)
  -- Mappings.
  local filetype = vim.api.nvim_get_option_value("filetype", {})
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

  nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
  nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
  nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
  nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<A-k>", vim.lsp.buf.signature_help, "Signature Documentation")

  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })


  -- Attach any filetype specific options to the client
  M.filetype_attach[filetype](client)
end

M.default_capabilities = vim.lsp.protocol.make_client_capabilities()
M.default_capabilities.textDocument.codeLens = { dynamicRegistration = false }
M.default_capabilities.textDocument.completion.completionItem.snippetSupport = true
M.default_capabilities = require("cmp_nvim_lsp").default_capabilities(M.default_capabilities)

return M
