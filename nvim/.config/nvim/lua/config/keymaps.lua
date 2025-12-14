local map = function(s, lhs, rhs, desc, opts)
	local localopts = { noremap = true, desc = desc }

	if opts then
		for k, v in pairs(opts) do
			localopts[k] = v
		end
	end
	vim.keymap.set(s, lhs, rhs, localopts)
end

vim.keymap.set({ "t", "x" }, "<esc><esc>", "<c-\\><c-n>", { desc = "Out of the terminal input" })
map("t", "<c-j>", "<C-\\><C-n><C-w>j")
map("t", "<c-k>", "<C-\\><C-n><C-w>k")
map("t", "<c-l>", "<C-\\><C-n><C-w>l")
map("t", "<c-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

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
map("n", "<M-k>", "<C-W>+", "[RESISE] increase height")
map("n", "<M-j>", "<C-W>-", "[RESISE] decrease height")
map("n", "<M-h>", "<c-w>8<", "[RESISE] increase width")
map("n", "<M-l>", "<c-w>8>", "[RESISE] decrease width")
--easyalign
map("n", "ga", "<Plug>(EasyAlign)", "[ALIGN]")
map("x", "ga", "<Plug>(EasyAlign)", "[ALIGN]")
-- git
-- SourceFiles
map("n", "<leader>so", "<cmd>so %<cr>", "[S]ource [O]nly current file")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
