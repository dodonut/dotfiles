if !exists(':Fern')
    finish
endif

" nnoremap <leader>k :Fern . -reveal=% -drawer -width=40 -toggle<cr>

function! s:init_fern() abort
  " Use 'select' instead of 'edit' for default 'open' action
  echo 'aqui'
  nmap <buffer> <Plug>(fern-action-open) <Plug>(fern-action-open:select)

  " Define NERDTree like mappings
  nmap <buffer> o <Plug>(fern-action-open:edit)
  nmap <buffer> go <Plug>(fern-action-open:edit)<C-w>p
  nmap <buffer> t <Plug>(fern-action-open:tabedit)
  nmap <buffer> T <Plug>(fern-action-open:tabedit)gT
  nmap <buffer> i <Plug>(fern-action-open:split)
  nmap <buffer> gi <Plug>(fern-action-open:split)<C-w>p
  nmap <buffer> s <Plug>(fern-action-open:vsplit)
  nmap <buffer> gs <Plug>(fern-action-open:vsplit)<C-w>p
  nmap <buffer> n <Plug>(fern-action-new-path)
  nmap <buffer> P gg

  nmap <buffer> C <Plug>(fern-action-enter)
  nmap <buffer> u <Plug>(fern-action-leave)
  nmap <buffer> r <Plug>(fern-action-reload)
  nmap <buffer> R gg<Plug>(fern-action-reload)<C-o>
  nmap <buffer> cd <Plug>(fern-action-cd)
  nmap <buffer> CD gg<Plug>(fern-action-cd)<C-o>

  nmap <buffer> I <Plug>(fern-action-hide-toggle)

  nmap <buffer> q :<C-u>quit<CR>


  " preview like in vscode
  " nmap <buffer><expr>
  "       \ <Plug>(fern-my-preview-or-nop)
  "       \ fern#smart#leaf(
  "       \   "\<Plug>(fern-action-open:edit)\<C-w>p",
  "       \   "",
  "       \ )
  " nmap <buffer><expr> j
  "       \ fern#smart#drawer(
  "       \   "j\<Plug>(fern-my-preview-or-nop)",
  "       \   "j",
  "       \ )
  " nmap <buffer><expr> k
  "       \ fern#smart#drawer(
  "       \   "k\<Plug>(fern-my-preview-or-nop)",
  "       \   "k",
  "       \ )

endfunction

" augroup fern-custom
"   autocmd! *
"   autocmd FileType fern call s:init_fern()
" augroup END
