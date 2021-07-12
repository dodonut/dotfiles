if require('first_load')() then
	return
end

vim.g.mapleader = ','

vim.cmd[[
    let g:neosolorized_termtrans=1
    runtime ./after/colors/nvcode.vim
    colorscheme nvcode
]]

require('options')
require('plugin')





