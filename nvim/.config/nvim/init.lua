if require('first_load')() then
	return
end

vim.api.nvim_command('autocmd CursorHold * silent! checktime')

vim.g.mapleader = ','

require('options')
require('plugin')
