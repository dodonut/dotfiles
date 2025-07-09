local bufnr = vim.api.nvim_get_current_buf()
vim.api.nvim_buf_create_user_command(bufnr, 'PPRun', function(_)
    vim.api.nvim_command(":!python3 % < input.txt")
end, { desc = 'Run program for competitive' })
