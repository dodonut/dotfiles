if require('first_load')() then
	return
end

vim.g.mapleader = ','

require('options')
require('plugin')
