
if !exists(':NvimTreeToggle') 
    echo 'Plugin nvim tree not installed'
    finish
endif 

nnoremap <leader>k :NvimTreeToggle<cr>
let g:nvim_tree_width = 40 
let g:nvim_tree_follow = 1
let g:nvim_tree_lsp_diagnostics = 1
let g:nvim_tree_update_cwd = 1
let g:nvim_tree_git_hl = 1
let g:nvim_tree_highlight_opened_files = 1
