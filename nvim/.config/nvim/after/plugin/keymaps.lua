
local map = function(key, opts)
  -- get the extra options
  local opts = opts or {noremap = true}
  for i, v in pairs(key) do
    if type(i) == 'string' then opts[i] = v end
  end

  -- basic support for buffer-scoped keybindings
  local buffer = opts.buffer
  opts.buffer = nil

  if buffer then
    vim.api.nvim_buf_set_keymap(0, key[1], key[2], key[3], opts)
  else
    vim.api.nvim_set_keymap(key[1], key[2], key[3], opts)
  end
end

map({'t', '<c-j>', '<C-\\><C-n><C-w>j'})
map({'t', '<c-k>', '<C-\\><C-n><C-w>k'})
map({'t', '<c-l>', '<C-\\><C-n><C-w>l'})
map({'n', '<c-h>', '<C-w>h'})
map({'n', '<c-j>', '<C-w>j'})
map({'n', '<c-k>', '<C-w>k'})
map({'n', '<c-l>', '<C-w>l'})
map({'n', '<leader>v', ':vs<cr>'})
map({'n', '<leader>h', ':sp<cr>'})
map({'n', '<c-right>', ':bnext<cr>'})
map({'n', '<c-left>', ':bprevious<cr>'})
map({'n', '<right>', ':tabnext<cr>'})
map({'n', '<left>', ':tabprevious<cr>'})
map({'n', '<c-n>', ':tabnew<cr>'})
-- map({'v', 'p', '"_dP'})
map({'n', '<leader>x', ':close<cr>'})
map({'n', '<leader>,', ':w!<cr>'})
--save and source
map({'n', '<space>ss', ':w!<cr> <bar> :so %<cr>'})
-- greates remap everrrrrrr
map({'n', ':', ';'})
map({'n', ';', ':'})
map({'v', ':', ';'})
map({'v', ';', ':'})
-- scroll
map({'n', '<c-e>', '4<c-e>'})
map({'n', '<c-y>', '4<c-y>'})
-- keep selected while shifting
map({'v', '<', '<gv'})
map({'v', '>', '>gv'})
--resize
map({'n', '<a-up>',':resize +3<cr>'})
map({'n', '<a-down>',':resize -3<cr>'})
map({'n', '<a-left>',':vert resize -5<cr>'})
map({'n', '<a-right>',':vert resize +5<cr>'})

--easyalign
map({'n', 'ga','<Plug>(EasyAlign)'})
map({'x', 'ga','<Plug>(EasyAlign)'})

-- git
map({'n', '<leader>gg',':G<cr>'})
map({'n', '<leader>gc',':lua require("functions").fugitive()<cr>'})

-- sql
map({'n', '<leader>dt',':DBUIToggle<cr>'})
map({'x', '<expr><Plug>(DBExe)','DBExe()'})
map({'n', '<expr><Plug>(DBExe)','DBExe()'})
map({'n', '<expr><Plug>(DBExeLine)','DBExe()'})
map({'x', '<leader>db','<Plug>(DBExe)'})
map({'n', '<leader>db','<Plug>(DBExe)'})
map({'o', '<leader>db','<Plug>(DBExe)'})
map({'n', '<leader>dB','<Plug>(DBExeLine)'})

-- SourceFiles
map({'n', '<leader>sv','<cmd>lua require("functions").sourceFiles()<cr>'})

--trouble
map({'n', '<leader>tt','<cmd>TroubleToggle workspace_diagnostics<cr>'})
map({'n', '<leader>tq','<cmd>TroubleToggle quickfix<cr>'})

-- tests
map({'n', '<space>tf',':TestFile<cr>'})
map({'n', '<space>tn',':TestNearest<cr>'})
map({'n', '<space>ts',':TestSuite<cr>'})

--dap
map({'n', '<F6>',':lua require"dap".step_back()<CR>'})
map({'n', '<F7>',':lua require"dap".step_into()<CR>'})
map({'n', '<F8>',':lua require"dap".step_over()<CR>'})
map({'n', '<F9>',':lua require"dap".continue();require"dap".up();require"dapui".open()<CR>'})
map({'n', '<F12>',':lua require"dap".disconnect();require"dap".close();require"dapui".close()<CR>'})
map({'n', '<A-b>',':lua require"dap".toggle_breakpoint()<CR>'}, {noremap=true, silent=true})
map({'n', '<A-B>',':lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>'}, {noremap = true, silent = true})
map({'n', '<A-o>',':lua require"dap".repl.open()<CR>'}, {noremap = true, silent = true})
map({'n', '<A-h>',':lua require("dap.ui.widgets").hover()<CR>'})
map({'v', '<A-k>',':lua require("dapui").eval()<CR>'}, {noremap = true, silent = true})
map({'n', '<space>fdb',':lua require("functions").list_breakpoints()<CR>'}, {noremap = true, silent = true})
map({'n', '<space>dc',':lua require("dap").clear_breakpoints()<CR>'}, {noremap = true, silent = true})

--tree
-- map({'n', '<leader>k',':NvimTreeToggle<cr>'})
map({'n', '<leader>k',':Neotree filesystem reveal right toggle<cr>'})

--cheat
map({'n', '<leader>sc', ':Cheat<cr>'})

--open log map
vim.cmd [[
command! OpenLspLog :vsplit ~/.cache/nvim/lsp.log
]]

-- highlight text
map({'n', 'n', '<Plug>(highlight-current-n-n)'})
map({'n', 'N', '<Plug>(highlight-current-n-N)'})
