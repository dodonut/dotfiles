if not pcall(require, 'dap') then
    print 'dap not installed'
    return
end

local dap = require('dap')
dap.set_log_level "TRACE"

vim.cmd [[nnoremap <silent> <F9> :lua require'dap'.continue()<CR>]]
vim.cmd [[nnoremap <silent> <F7> :lua require'dap'.step_into()<CR>]]
vim.cmd [[nnoremap <silent> <F8> :lua require'dap'.step_over()<CR>]]

vim.cmd [[nnoremap <silent> <leader>db :lua require'dap'.toggle_breakpoint()<CR>]]
vim.cmd [[nnoremap <silent> <leader>dB :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>]]
vim.cmd [[nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>]]
vim.cmd [[nnoremap <silent> <space>dh :lua require('dap.ui.variables').hover()<CR>]]

local dap_ui = require "dapui"

local _ = dap_ui.setup {
  -- You can change the order of elements in the sidebar
  sidebar = {
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
        id = "scopes",
        size = 0.75, -- Can be float or integer > 1
      },
      { id = "watches", size = 00.25 },
    },
    size = 50,
    position = "left", -- Can be "left" or "right"
  },

  tray = {
    elements = { "repl" },
    size = 15,
    position = "bottom", -- Can be "bottom" or "top"
  },
}

dap.listeners.after.event_initialized["dapui_config"] = function()
  dap_ui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dap_ui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dap_ui.close()
end
-- dap.adapters.java = {

-- }
