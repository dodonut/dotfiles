require('vm.globals')

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.snippets = 'luasnip'

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  spec = {
    import = 'plugins'
  },
  -- change_detection = {
  --   notify = false
  -- }
})
require("options")
require('keymaps')
require('autocommands')
require('luasnip.loaders.from_lua').load({ paths = { './lua/snippets' } })

vim.api.nvim_command("colorscheme tokyonight")
