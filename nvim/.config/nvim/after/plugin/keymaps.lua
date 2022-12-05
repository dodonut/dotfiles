
Map("t", "<c-j>", "<C-\\><C-n><C-w>j")
Map("t", "<c-k>", "<C-\\><C-n><C-w>k")
Map("t", "<c-l>", "<C-\\><C-n><C-w>l")
Map("n", "<c-h>", "<C-w>h")
Map("n", "<c-j>", "<C-w>j")
Map("n", "<c-k>", "<C-w>k")
Map("n", "<c-l>", "<C-w>l")
Map("n", "<leader>v", ":vs<cr>")
Map("n", "<leader>h", ":sp<cr>")
Map("n", "<c-right>", ":bnext<cr>")
Map("n", "<c-left>", ":bprevious<cr>")
Map("n", "<right>", ":tabnext<cr>")
Map("n", "<left>", ":tabprevious<cr>")
Map("n", "<c-n>", ":tabnew<cr>")
-- Map('v', 'p', '"_dP')
Map("n", "<leader>x", ":close<cr>")
Map("n", "<leader>,", ":w!<cr>")
--save and source
Map("n", "<space>ss", ":w!<cr> <bar> :so %<cr>")
-- greates reMap everrrrrrr
Map("n", ":", ";")
Map("n", ";", ":")
Map("v", ":", ";")
Map("v", ";", ":")
-- scroll
Map("n", "<c-e>", "4<c-e>")
Map("n", "<c-y>", "4<c-y>")
-- keep selected while shifting
Map("v", "<", "<gv")
Map("v", ">", ">gv")
--resize
Map("n", "<a-up>", ":resize +3<cr>")
Map("n", "<a-down>", ":resize -3<cr>")
Map("n", "<a-left>", ":vert resize -5<cr>")
Map("n", "<a-right>", ":vert resize +5<cr>")
--easyalign
Map("n", "ga", "<Plug>(EasyAlign)")
Map("x", "ga", "<Plug>(EasyAlign)")
-- git
Map("n", "<leader>gg", ":Neogit<cr>")
-- SourceFiles
Map("n", "<leader>sv", '<cmd>lua require("functions").sourceFiles()<cr>')
--trouble
Map("n", "<leader>tt", "<cmd>TroubleToggle workspace_diagnostics<cr>")
Map("n", "<leader>tq", "<cmd>TroubleToggle quickfix<cr>")
-- tests
Map("n", "<space>tf", ":TestFile<cr>")
Map("n", "<space>tn", ":TestNearest<cr>")
Map("n", "<space>ts", ":TestSuite<cr>")
--dap
Map("n", "<F6>", require("dap").step_back, "[DAP] step_back")
Map("n", "<F7>", require("dap").step_into, "[DAP] step_into")
Map("n", "<F8>", require("dap").step_over, "[DAP] step_over")
Map("n", "<F9>", require("dap").step_out, "[DAP] step_out")
Map("n", "<F11>", require("dap").continue, "[DAP] continue")
Map("n", "<F12>", require("dap").terminate, "[DAP] terminate")
Map("n", "<leader>dr", require("dap").repl.open, "[DAP] repl open")
Map("n", "<leader>db", require("dap").toggle_breakpoint, "[DAP] toggle breakpoint")
Map("n", "<leader>dB", function()
	require("dap").set_breakpoint(vim.fn.input("[DAP] Condition > "), "[DAP] condition")
end, "breakpoint condition")
Map("v", "<leader>de", require("dapui").eval, "[DAPUI] eval")
Map("n", "<leader>dE", function()
	require("dapui").eval(vim.fn.input("[DAP] Expression > "), "[DAPUI] expression")
end)
Map("n", "<leader>dT", "<cmd> lua require'dapui'.toggle()<cr>", "[DAPUI] toggle")

Map("n", "<leader>k", ":Neotree filesystem reveal left toggle<cr>")
--cheat
Map("n", "<leader>sc", ":Cheat<cr>")
--open log Map
vim.cmd([[
command! OpenLspLog :vsplit ~/.cache/nvim/lsp.log
]])
-- terminal
Map("n", "<c-\\>", ":FloatermToggle<cr>")
-- highlight text
Map("n", "n", "<Plug>(highlight-current-n-n)")
Map("n", "N", "<Plug>(highlight-current-n-N)")
--Spectre
Map("n", "<leader>S", '<cmd>lua require("spectre").open()<CR>')
