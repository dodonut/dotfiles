-- ./after/plugin/* contains configs for plugins in vim
-- ./lua/plugins* contains configs for plugins in lua
-- Files on ./after/* and ./lua/plugins are sourced automatically if the name of the file matches the name of the plugin

-- install packer if it does not have
if require('vm.first_load')() then
    return

end

vim.g.mapleader = ','

-- Setup globals that I expect to be always available.
--  See `./lua/vm/globals/*.lua` for more information.
require('vm.globals')

-- Load packer.nvim files
require('vm.plugins')

-- Load neovim options
require('vm.options')
require('plugin')

-- Neovim builtin LSP configuration
require('vm.lsp')

-- Telescope BTW
require('vm.telescope')
-- require('vm.telescope.mappings')



