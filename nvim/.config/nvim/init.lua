if require("vm.first_load")() then
	return
end

vim.g.mapleader = ","
vim.g.snippets = "ultisnips"

require 'vm.globals'
require 'vm.lsp'
require 'vm.telescope.setup'
require 'vm.telescope.mappings'
require("options")
require("plugins")
