if not pcall(require, "nvim-tree") then
  print('nvim-tree not installed')
	return
end

vim.g.nvim_tree_group_empty = 1

-- autoclose the editor when the last window is the nvimtree
local id = vim.api.nvim_create_augroup("autoclose_vim_nvimtree", { clear = true })
vim.api.nvim_create_autocmd(
	"bufenter",
	{ pattern = "*", command = "if (winnr('$') == 1 && expand('%') == 'NvimTree_1') | q | endif", group = id }
)
-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
require'nvim-tree'.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = true,
  update_to_buf_dir   = {
    enable = false,
    auto_open = false,
  },
  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_focused_file = {
    enable      = true,
    update_cwd  = false,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    dotfiles = true,
    custom = {}
  },
  view = {
    width = 50,
    height = 30,
    hide_root_folder = false,
    side = 'right',
    auto_resize = true,
    mappings = {
      custom_only = false,
      list = {}
    }
  }
}
