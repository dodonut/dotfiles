

vim.cmd[[
let test#strategy='neovim'
let test#neovim#term_position = "vert 70"
let test#neovim#start_normal = 1 " if using neovim strategy

let test#java#runner='gradletest'
let test#go#runner='richgo'
]]

