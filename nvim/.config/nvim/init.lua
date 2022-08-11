vim.g.mapleader = ","
vim.g.snippets = "ultisnips"
vim.g.python3_host_prog = vim.fn.expand('/usr/bin/python3.6')
vim.g['far#enable_undo'] = 1
vim.g['far#default_file_mask'] = '**/*.*'

require 'vm.globals'
require 'vm.lsp'
require 'vm.telescope.setup'
require 'vm.telescope.mappings'
require("options")
require("plugins")

