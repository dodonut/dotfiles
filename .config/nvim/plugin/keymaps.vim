" This is where most of my basic keymapping goes.
"   Plugin keymaps will all be found in `./after/plugin/*`


" navigation
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <leader>v :vs<cr>
nnoremap <leader>h :sp<cr>
nnoremap <up> :tabnext<cr>
nnoremap <down> :tabprevious<cr>
nnoremap <right> :bnext<cr>
nnoremap <left> :bprevious<cr>


" close tab or buffer
nnoremap <leader>x :close<cr>

" save file
nnoremap <leader>, :w!<CR>

" greatest remap everrrrrrr
nnoremap : ;
nnoremap ; :

vnoremap : ;
vnoremap ; :

" does not work on go files because of vim-go mapping for :GoDef on same key,,
nnoremap <C-t> :tabnew<cr>

" better <esc>
inoremap jk <esc> 

nnoremap <leader>sv <cmd>luafile ~/.config/nvim/init.lua<cr>

nnoremap <silent><leader>ca :Lspsaga code_action<CR>
vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>
nnoremap <silent>K :Lspsaga hover_doc<CR>
"scroll down hover doc or scroll in definition preview
nnoremap <silent> <C-d> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
" scroll up hover doc
nnoremap <silent> <C-u> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
nnoremap <silent> gs :Lspsaga signature_help<CR>
nnoremap <silent> gh :Lspsaga lsp_finder<CR>
nnoremap <silent> gr :Lspsaga rename<CR>
nnoremap <leader>vr :lua vim.lsp.buf.rename()<CR>
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
"nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent><space>a <cmd>LspTroubleToggle<CR>

nnoremap <silent>    <leader>x :BufferClose<CR>

let g:cmake_link_compile_commands = 1

nnoremap <leader>mg :CMakeGenerate<cr>
nnoremap <leader>mc :CMakeBuild<cr>
