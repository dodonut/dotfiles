lua << EOF

if not pcall(require, 'neogit') then
    print('neogit not installed')
    return
end

if not pcall(require, 'diffview') then
    print('diffview not installed')
    return
end

require('neogit').setup {
    disable_commit_confirmation=true,
    integrations = {
        diffview = true
        }
    }
EOF


nnoremap <leader>gg :Neogit<cr>
nnoremap <leader>gd :DiffviewOpen<cr>
nnoremap <leader>gc :DiffviewClose<cr>
nnoremap <leader>gD :DiffviewOpen master<cr>
nnoremap <leader>gl :Neogit log<cr>
