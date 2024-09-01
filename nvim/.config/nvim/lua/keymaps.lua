local map = function(s, lhs, rhs, desc, opts)
  local localopts = { noremap = true, desc = desc }

  if opts then
    for k, v in pairs(opts) do
      localopts[k] = v
    end
  end
  vim.keymap.set(s, lhs, rhs, localopts)
end

map("t", "<c-j>", "<C-\\><C-n><C-w>j")
map("t", "<c-k>", "<C-\\><C-n><C-w>k")
map("t", "<c-l>", "<C-\\><C-n><C-w>l")
map("n", "<c-h>", "<C-w>h")
map("n", "<c-j>", "<C-w>j")
map("n", "<c-k>", "<C-w>k")
map("n", "<c-l>", "<C-w>l")
map("n", "<leader>vs", ":vs<cr>", "[V]ertical [S]plit")
map("n", "<leader>hs", ":sp<cr>", "[H]orizontal [S]plit")

map("n", "<leader>mh", "<c-w>t<c-w>H", "[M]ove [H]orizontal split to vertical")
-- greates remap everrrrrrr
map("n", ":", ";")
map("n", ";", ":")
map("v", ":", ";")
map("v", ";", ":")
-- scroll
map("n", "<c-e>", "4<c-e>", "scroll down")
map("n", "<c-y>", "4<c-y>", "scroll up")
-- keep selected while shifting
map("v", "<", "<gv", "indenting backwards")
map("v", ">", ">gv", "indenting forwards")
--resize
map("n", "<a-up>", ":resize +3<cr>", "[RESISE] up")
map("n", "<a-down>", ":resize -3<cr>", "[RESISE] down")
map("n", "<a-left>", ":vert resize -5<cr>", "[RESISE] left")
map("n", "<a-right>", ":vert resize +5<cr>", "[RESISE] right")
--easyalign
map("n", "ga", "<Plug>(EasyAlign)", "[ALIGN]")
map("x", "ga", "<Plug>(EasyAlign)", "[ALIGN]")
-- git
-- SourceFiles
map("n", "<leader>sv", '<cmd>lua require("vm.functions").sourceFiles()<cr>', "[S]ource [V]im")
map("n", "<leader>so", '<cmd>so %<cr>', "[S]ource [O]nly current file")

map("n", "<localleader>t", ":Neotree filesystem reveal left toggle<cr>", "[T]ree reveal")
-- terminal
-- highlight text
map("n", "n", "<Plug>(highlight-current-n-n)")
map("n", "N", "<Plug>(highlight-current-n-N)")
--diagnostics
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = -1, float = true }) end,
  { noremap = true, desc = 'prev [D]iagnostic' })

vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = 1, float = true }) end,
  { noremap = true, desc = 'next [D]iagnostic' })

map('n', '<leader>gl', ':G log<cr>', '[G]it [L]og')


vim.keymap.set('v', '<leader>gl', function()
  local visual_sel_lines = {
    vim.fn.line('v'),
    vim.fn.line('.')
  }
  local line_start = math.min(unpack(visual_sel_lines))
  local line_end = math.max(unpack(visual_sel_lines))
  vim.cmd("G log -L" .. line_start .. "," .. line_end .. ":%")
end, { desc = '[G]it [L]og' })
