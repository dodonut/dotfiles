



" holy
nnoremap <c-p>      <cmd>lua require('vm.telescope.functions').git_files()<cr>
nnoremap <c-f>      <cmd>lua require('vm.telescope.functions').find_files()<cr>
nnoremap <leader>ev <cmd>lua require('vm.telescope.functions').edit_neovim()<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fB <cmd>Telescope buffers<cr>
nnoremap <leader>fb <cmd>lua require('vm.telescope.functions').file_browser()<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fq <cmd>Telescope quick_fix<cr>
nnoremap <leader>fc <cmd>Telescope commands<cr>
nnoremap <leader>fk <cmd>Telescope keymaps<cr>
