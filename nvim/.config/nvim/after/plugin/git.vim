
" open fugitive in a tab
" command! Gt execute "Gtabedit :"

function NeogitSetup() 
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

if not pcall(require, 'gitsigns') then
    print('gitsigns not installed')
    return
end

require'gitsigns'.setup{}
EOF


nnoremap <leader>gg :Neogit<cr>
nnoremap <leader>gd :DiffviewOpen<cr>
nnoremap <leader>gc :DiffviewClose<cr>
nnoremap <leader>gD :DiffviewOpen master<cr>
" nnoremap <leader>gl :Neogit log<cr>

set nocompatible
filetype plugin indent on
let g:mergetool_layout = 'bmr'
let g:mergetool_prefer_revision = 'local'

endfunction

" neogit_setup()

function! Fugitive() 

    function! GPushAll()
        let message=input("Message > ")
        " add all files because git add . don't work in the way I open VC
        silent execute "!git add $(git rev-parse --show-cdup)"
        silent G commit -m a:message
        silent execute "!git push -u origin " . system('git branch')[2:-2]
        redraw
        echo "Done!"
    endfunction

nnoremap <leader>gg :G<cr>
nnoremap <leader>gd :DiffviewOpen<cr>
nnoremap <leader>gx :DiffviewClose<cr>
nnoremap <leader>gc :call GPushAll()<cr>
nnoremap <leader>gD :DiffviewOpen master<cr>
    
endfunction

call Fugitive()
