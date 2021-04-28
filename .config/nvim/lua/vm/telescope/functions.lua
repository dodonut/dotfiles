
  local M = {}


  function M.file_browser()
      require('telescope.builtin').file_browser {
        hidden = true,
        prompt = " ~ FileBrowser ~ ",
        height = 10,

        layout_strategy = 'horizontal',
        layout_options = {
            preview_width = 0.75,
        }
      }
  end

  function M.git_files()
     require('telescope.builtin').git_files {
        shorten_path = false,
        prompt = " ~ git files ~ ",
        height = 10,

        layout_strategy = 'horizontal',
        layout_options = {
            preview_width = 0.75,
        }
      }
  end

  function M.find_files()
      require('telescope.builtin').find_files {
        shorten_path = true,
        prompt = " ~ all files ~ ",
        height = 10,

        layout_strategy = 'horizontal',
        layout_options = {
            preview_width = 0.75,
        }
      }
  end

  function M.edit_neovim()
      require('telescope.builtin').find_files {
        shorten_path = true,
        cwd = "~/.config/nvim",
        prompt = " ~ dotfiles ~ ",
        height = 10,

        layout_strategy = 'horizontal',
        layout_options = {
            preview_width = 0.75,
        }
      }
  end

  return M
