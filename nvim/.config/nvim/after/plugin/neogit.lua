
if not pcall(require, 'neogit') then
    print('neogit not installed')
    return
end


vim.cmd[[nnoremap <leader>g :Neogit<cr>]]
