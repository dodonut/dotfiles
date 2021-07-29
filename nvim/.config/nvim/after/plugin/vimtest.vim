if has('nvim')
    let test#strategy='neovim'
else
    let test#strategy='vimterminal'
endif

let test#java#runner='gradletest'
let test#javascript#runner='jest'
