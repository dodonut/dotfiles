

-- navigation
vim.cmd[[tnoremap <C-h> <C-\><C-n><C-w>h]]
vim.cmd[[tnoremap <C-j> <C-\><C-n><C-w>j]]
vim.cmd[[tnoremap <C-k> <C-\><C-n><C-w>k]]
vim.cmd[[tnoremap <C-l> <C-\><C-n><C-w>l]]
vim.cmd[[nnoremap <C-h> <C-w>h]]
vim.cmd[[nnoremap <C-j> <C-w>j]]
vim.cmd[[nnoremap <C-k> <C-w>k]]
vim.cmd[[nnoremap <C-l> <C-w>l]]
vim.cmd[[nnoremap <leader>v :vs<cr>]]
vim.cmd[[nnoremap <leader>h :sp<cr>]]
vim.cmd[[nnoremap <up> :tabnext<cr>]]
vim.cmd[[nnoremap <down> :tabprevious<cr>]]
vim.cmd[[nnoremap <right> :bnext<cr>]]
vim.cmd[[nnoremap <left> :bprevious<cr>]]

-- close tab or buffer
vim.cmd[[nnoremap <leader>x :close<cr>]]

-- save file
vim.cmd[[nnoremap <leader>, :w!<CR>]]

-- greatest remap everrrrrrr
vim.cmd[[nnoremap : ;]]
vim.cmd[[nnoremap ; :]]

vim.cmd[[vnoremap : ;]]
vim.cmd[[vnoremap ; :]]

-- does not work on go files because of vim-go mapping for :GoDef on same key,,
vim.cmd[[nnoremap <C-t> :tabnew<cr>]]

-- better <esc>
vim.cmd[[inoremap jk <esc> ]]

vim.cmd[[nnoremap <leader>sv :so ~/.config/nvim/init.lua<cr>]]
