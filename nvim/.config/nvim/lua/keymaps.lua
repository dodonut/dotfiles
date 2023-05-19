local map = require 'vm.functions'.map

map("t", "<c-j>", "<C-\\><C-n><C-w>j")
map("t", "<c-k>", "<C-\\><C-n><C-w>k")
map("t", "<c-l>", "<C-\\><C-n><C-w>l")
map("n", "<c-h>", "<C-w>h")
map("n", "<c-j>", "<C-w>j")
map("n", "<c-k>", "<C-w>k")
map("n", "<c-l>", "<C-w>l")
map("n", "<leader>vs", ":vs<cr>", "[V]ertical [S]plit")
map("n", "<leader>hs", ":sp<cr>", "[H]orizontal [S]plit")
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
-- SourceFiles
map("n", "<leader>sv", '<cmd>lua require("functions").sourceFiles()<cr>')

map("n", ",t", ":Neotree filesystem reveal left toggle<cr>")
-- terminal
-- highlight text
map("n", "n", "<Plug>(highlight-current-n-n)")
map("n", "N", "<Plug>(highlight-current-n-N)")
