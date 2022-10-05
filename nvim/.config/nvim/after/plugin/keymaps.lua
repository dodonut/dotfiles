local map = function(s, lhs, rhs, desc)
	-- get the extra options
	if desc then
		desc = "[DAP] " .. desc
	end
	local opts = { noremap = true, desc = desc }
	-- basic support for buffer-scoped keybindings
	vim.keymap.set(s, lhs, rhs, opts)
end

map("t", "<c-j>", "<C-\\><C-n><C-w>j")
map("t", "<c-k>", "<C-\\><C-n><C-w>k")
map("t", "<c-l>", "<C-\\><C-n><C-w>l")
map("n", "<c-h>", "<C-w>h")
map("n", "<c-j>", "<C-w>j")
map("n", "<c-k>", "<C-w>k")
map("n", "<c-l>", "<C-w>l")
map("n", "<leader>v", ":vs<cr>")
map("n", "<leader>h", ":sp<cr>")
map("n", "<c-right>", ":bnext<cr>")
map("n", "<c-left>", ":bprevious<cr>")
map("n", "<right>", ":tabnext<cr>")
map("n", "<left>", ":tabprevious<cr>")
map("n", "<c-n>", ":tabnew<cr>")
-- map('v', 'p', '"_dP')
map("n", "<leader>x", ":close<cr>")
map("n", "<leader>,", ":w!<cr>")
--save and source
map("n", "<space>ss", ":w!<cr> <bar> :so %<cr>")
-- greates remap everrrrrrr
map("n", ":", ";")
map("n", ";", ":")
map("v", ":", ";")
map("v", ";", ":")
-- scroll
map("n", "<c-e>", "4<c-e>")
map("n", "<c-y>", "4<c-y>")
-- keep selected while shifting
map("v", "<", "<gv")
map("v", ">", ">gv")
--resize
map("n", "<a-up>", ":resize +3<cr>")
map("n", "<a-down>", ":resize -3<cr>")
map("n", "<a-left>", ":vert resize -5<cr>")
map("n", "<a-right>", ":vert resize +5<cr>")
--easyalign
map("n", "ga", "<Plug>(EasyAlign)")
map("x", "ga", "<Plug>(EasyAlign)")
-- git
map("n", "<leader>gg", ":Neogit<cr>")
-- SourceFiles
map("n", "<leader>sv", '<cmd>lua require("functions").sourceFiles()<cr>')
--trouble
map("n", "<leader>tt", "<cmd>TroubleToggle workspace_diagnostics<cr>")
map("n", "<leader>tq", "<cmd>TroubleToggle quickfix<cr>")
-- tests
map("n", "<space>tf", ":TestFile<cr>")
map("n", "<space>tn", ":TestNearest<cr>")
map("n", "<space>ts", ":TestSuite<cr>")
--dap
map("n", "<F6>", require("dap").step_back, "step_back")
map("n", "<F7>", require("dap").step_into, "step_into")
map("n", "<F8>", require("dap").step_over, "step_over")
map("n", "<F9>", require("dap").step_out, "step_out")
map("n", "<F11>", require("dap").continue, "continue")
map("n", "<F12>", require("dap").terminate, "terminate")
map("n", "<leader>dr", require("dap").repl.open)
map("n", "<leader>db", require("dap").toggle_breakpoint)
map("n", "<leader>dB", function()
	require("dap").set_breakpoint(vim.fn.input("[DAP] Condition > "))
end)
map("v", "<leader>de", require("dapui").eval)
map("n", "<leader>dE", function()
	require("dapui").eval(vim.fn.input("[DAP] Expression > "))
end)

map("n", "<leader>k", ":Neotree filesystem reveal right toggle<cr>")
--cheat
map("n", "<leader>sc", ":Cheat<cr>")
--open log map
vim.cmd([[
command! OpenLspLog :vsplit ~/.cache/nvim/lsp.log
]])
-- terminal
map("n", "<c-\\>", ":FloatermToggle<cr>")
-- highlight text
map("n", "n", "<Plug>(highlight-current-n-n)")
map("n", "N", "<Plug>(highlight-current-n-N)")
--Spectre
map("n", "<leader>S", '<cmd>lua require("spectre").open()<CR>')
