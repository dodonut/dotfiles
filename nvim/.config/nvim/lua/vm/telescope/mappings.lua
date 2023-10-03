local map_tele = require('vm.telescope.functions').map_tele
-- Search
map_tele("<c-p>", "git_files")
map_tele("<leader>fg", "live_grep")
map_tele("<leader><space>", "buffers")
map_tele("<leader>fa", "search_all_files")
map_tele("<leader>ff", "curbuf")
map_tele("<leader>fh", "help_tags")
map_tele("<leader>fw", "grep_prompt", {
    word_match = "-w",
    short_path = true,
    only_sort_text = true,
    layout_strategy = "vertical",
}, "v")
vim.api.nvim_set_keymap("n", "<leader>fk", "<cmd>Telescope keymaps<cr>",
    { noremap = true, silent = true, desc = "[TELE] keymaps" })
vim.api.nvim_set_keymap("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>",
    { noremap = true, silent = true, desc = "[TELE] diagnostics" })
