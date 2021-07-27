if has('nvim')
    let test#strategy='dispatch'
else
    let test#strategy='vimterminal'
endif

let test#java#runner='gradletest'
" let test#java#gradletest#executable=''
