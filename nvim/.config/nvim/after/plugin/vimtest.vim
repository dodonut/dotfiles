let test#strategy='neovim'
  " let test#strategy = {
  "   \ 'nearest': 'neovim',
  "   \ 'file':    'neovim',
  "   \ 'suite':   'basic',
  " \}
let test#neovim#term_position = "vert 70"
let test#neovim#start_normal = 1 " if using neovim strategy

let test#java#runner='gradletest'
let test#javascript#runner='jest'

nnoremap <space>tf :TestFile<cr>
nnoremap <space>tn :TestNearest<cr>
nnoremap <space>ts :TestSuite<cr>
