vim.keymap.set('n', "<leader>to", "<cmd>JavaTestViewLastReport<cr>",
    { noremap = true, desc = "Java [T]est [O]pen last report" })

vim.keymap.set('n', "<leader>td", "<cmd>JavaTestDebugCurrentMethod<cr>",
    { noremap = true, desc = "Java [T]est [D]ebug" })

vim.keymap.set('n', "<leader>tr", "<cmd>JavaTestRunCurrentClass<cr>",
    { noremap = true, desc = "Java [T]est [R]un for class" })

vim.api.nvim_buf_create_user_command(vim.api.nvim_get_current_buf(), 'Gtest', function(_)
    vim.api.nvim_command(":!./gradlew test")
end, { desc = 'Run ./gradlew test' })
