if not pcall(require, 'telescope') then
    return
  end
  
  local should_reload = true
  local reloader = function()
    if should_reload then
      RELOAD('plenary')
      RELOAD('popup')
      RELOAD('telescope')
    end
  end

  reloader()
  
  local actions = require('telescope.actions')
  local sorters = require('telescope.sorters')
  local themes = require('telescope.themes')
  
  -- local action_set = require('telescope.actions.set')
  -- local _ = require('nvim-nonicons')
  
  require('telescope').setup {
    defaults = {
      prompt_prefix = '❯ ',
      selection_caret = '❯ ',
      winblend = 0,
      preview_cutoff = 120,
      layout_strategy = 'horizontal',
      layout_defaults = {
        horizontal = {
          width_padding = 0.1,
          height_padding = 0.1,
          preview_width = 0.6,
        },
        vertical = {
          width_padding = 0.05,
          height_padding = 1,
          preview_height = 0.5,
        }
      },
  
      selection_strategy = "reset",
      sorting_strategy = "descending",
      scroll_strategy = "cycle",
      prompt_position = "top",
      color_devicons = true,
  
      mappings = {
        i = {
          ["<C-x>"] = false,
          ["<C-s>"] = actions.select_horizontal,
        },
      },
  
      borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
  
      file_sorter = sorters.get_fzy_sorter,
  
      file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
      grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
      qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    },
  
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      },
  
      fzf_writer = {
        use_highlighter = false,
        minimum_grep_characters = 6,
      },
    },
  }

  
