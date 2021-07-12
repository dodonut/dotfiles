
M = {}

  function M.file_browser()
      require('telescope.builtin').file_browser {
        hidden = true,
        prompt = " ~ FileBrowser ~ ",

        layout_strategy = 'horizontal',
        layout_options = {
            preview_width = 0.75,
        },
        layout_config = {
            height = 40,
        }
      }
  end


  function M.git_files()
     require('telescope.builtin').git_files {
        path_display ={  'shorten' },
        prompt = " ~ git files ~ ",

        layout_strategy = 'horizontal',
        layout_options = {
            preview_width = 0.75,
        },
        layout_config = {
            height = 40,
        }

      }
  end

  function M.find_files()
      require('telescope.builtin').find_files {
        prompt = " ~ all files ~ ",

        layout_strategy = 'horizontal',
        layout_options = {
            preview_width = 0.75,
        },
        layout_config = {
            height = 40,
        }

      }
  end

  function M.edit_neovim()
      require('telescope.builtin').find_files {
        path_display ={  'shorten' },
        cwd = "~/.config/nvim",
        prompt = " ~ dotfiles ~ ",

        layout_strategy = 'horizontal',
        layout_options = {
            preview_width = 0.75,
        },
        layout_config = {
            height = 40,
        }

      }
  end

  return M

