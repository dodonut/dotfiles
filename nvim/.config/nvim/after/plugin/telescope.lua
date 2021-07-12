
if not pcall(require, 'telescope') then
    print("Telescope Not installed")
    return
end

-- ctrl-p works for git and non-git repos
vim.cmd[[
    silent! !git rev-parse --is-inside-work-tree
    if v:shell_error == 0
        nnoremap <c-p> :lua require('telescope.functions').git_files()<cr>
    else
        nnoremap <c-p> :lua require('telescope.functions').find_files()<cr>
    endif
]]

vim.cmd[[nnoremap <leader>ev <cmd>lua require('telescope.functions').edit_neovim()<cr>]]
vim.cmd[[nnoremap <leader>fg <cmd>Telescope live_grep<cr> ]]
vim.cmd[[nnoremap <leader>fb <cmd>Telescope buffers<cr>   ]]
vim.cmd[[nnoremap <leader>fk <cmd>Telescope keymaps<cr>   ]]
vim.cmd[[nnoremap <leader>fh <cmd>Telescope help_tags<cr> ]]
vim.cmd[[nnoremap <leader>fq <cmd>Telescope quickfix<cr> ]]
vim.cmd[[nnoremap <leader>fc <cmd>Telescope commands<cr> ]]

