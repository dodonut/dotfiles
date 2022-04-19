local function org_imports_go(timeout_ms)
  local context = { source = { organizeImports = true } }
  vim.validate { context = { context, 't', true } }
  local params = vim.lsp.util.make_range_params()
  params.context = context

  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
  if not result then return end
  for _, v in pairs(result) do
      result = v.result
  end

  if not result then return end
  local edit = result[1].edit.documentChanges
  print('edit')
  P(edit)
  vim.lsp.util.apply_workspace_edit(edit)
end

local function fugitive()
    local message = vim.fn.input("Message > ")
    local branch = vim.fn.system("git branch | grep \\*")
    vim.fn.system("git add $(git rev-parse --show-toplevel)")
    vim.fn.system("git commit -m " .. message)
    -- vim.fn.system("git push -u origin " .. string.sub(branch, 2, -2))

    -- vim.api.nvim_exec("redraw", false)
    print("Done!")
end

fugitive()
