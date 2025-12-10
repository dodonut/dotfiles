require("config.custom.globals")
--NOTE: map leader before init the plugins with lazy
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.snippets = "luasnip"

-- if lazy spec is enabled, config folder is automatically loaded
require("config.options")
require("config.keymaps")
require('config.autocommands')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require("lazy").setup({
  spec = {
    { import = "plugins" },
    -- this will setup an "IDE" with a lot of keymaps predefined, i dont like
    -- {
    --   "LazyVim/LazyVim",
    --   opts = { colorscheme = "catppuccin-mocha" },
    --   import = "lazyvim.plugins",
    -- },
    -- { import = "lazyvim.plugins.extras.dap.core" },
    -- { import = "lazyvim.plugins.extras.test.core" },
  },
  change_detection = {
    enabled = false,
    notify = false,
  },
  check = {
    enabled = true,
    notify = false
  }
})

require("luasnip.loaders.from_lua").load({ paths = { "./lua/snippets" } })

vim.api.nvim_command("colorscheme onedark")
-- need to be set after the colorscheme set
-- vim.api.nvim_set_hl(0, 'LineNr', { fg = 'white' })
-- vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = 'white' })
-- vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = 'white' })
