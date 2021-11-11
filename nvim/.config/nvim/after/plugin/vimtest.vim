if has('nvim')
    " let test#strategy='neovim'
  let test#strategy = {
    \ 'nearest': 'neovim',
    \ 'file':    'dispatch',
    \ 'suite':   'basic',
  \}
    " let test#neovim#term_position = 'vertical'
else
    let test#strategy='vimterminal'
endif

let test#java#runner='gradletest'
let test#javascript#runner='jest'
