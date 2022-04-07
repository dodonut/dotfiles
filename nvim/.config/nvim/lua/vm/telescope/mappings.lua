if not pcall(require, 'telescope') then
  print 'telescope not installed'
  return
end


local sorters = require "telescope.sorters"

TelescopeMapArgs = TelescopeMapArgs or {}

-- stole from tj
local map_tele = function(key, f, options, buffer)
  local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

  TelescopeMapArgs[map_key] = options or {}

  local mode = "n"
  local rhs = string.format("<cmd>lua R('vm.telescope')['%s'](TelescopeMapArgs['%s'])<CR>", f, map_key)

  local map_options = {
    noremap = true,
    silent = true,
  }

  if not buffer then
    vim.api.nvim_set_keymap(mode, key, rhs, map_options)
  else
    vim.api.nvim_buf_set_keymap(0, mode, key, rhs, map_options)
  end
end

vim.api.nvim_set_keymap("c", "<c-r><c-r>", "<Plug>(TelescopeFuzzyCommandSearch)", { noremap = false, nowait = true })

-- Dotfiles
map_tele("<leader>en", "edit_neovim")

-- Search
map_tele("<space>gw", "grep_string", {
  short_path = true,
  word_match = "-w",
  only_sort_text = true,
  layout_strategy = "vertical",
  sorter = sorters.get_fzy_sorter(),
})
map_tele("<space>f/", "grep_last_search", {
  layout_strategy = "vertical",
})

-- Files
map_tele("<c-p>", "git_files")
map_tele("<space>fg", "live_grep")
-- map_tele("<space>fo", "oldfiles")
-- map_tele("<space>fd", "fd")
--TODO see this func project_search
-- map_tele("<space>pp", "project_search")
-- map_tele("<space>fe", "file_browser")
-- Nvim
map_tele("<space>fb", "buffers")
map_tele("<space>fa", "installed_plugins")
map_tele("<space>fi", "search_all_files")
map_tele("<space>ff", "curbuf")
map_tele("<space>fh", "help_tags")
map_tele("<space>fk", "keymaps")
-- quite unusual
map_tele("<space>vo", "vim_options")
-- Telescope Meta
map_tele("<space>fB", "builtin")
map_tele("<space>fs", "ultisnips")
map_tele("<space>fdb", "list_breakpoints")
-- not so useful
-- map_tele("<space>fz", "zoxide")
-- map_tele("<space>fr", "repo")

return map_tele
