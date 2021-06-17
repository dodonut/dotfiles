" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/viniciusmoraes/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/viniciusmoraes/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/viniciusmoraes/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/viniciusmoraes/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/viniciusmoraes/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  UltiSnips = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/UltiSnips"
  },
  ["auto-pairs"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/auto-pairs"
  },
  ["barbar.nvim"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/barbar.nvim"
  },
  ["completion-treesitter"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/completion-treesitter"
  },
  ["cyclist.vim"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/cyclist.vim"
  },
  ["exception.vim"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/exception.vim"
  },
  ["express_line.nvim"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/express_line.nvim"
  },
  ["far.vim"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/far.vim"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["jedi-vim"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/jedi-vim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/lsp-status.nvim"
  },
  ["lsp-trouble.nvim"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/lsp-trouble.nvim"
  },
  ["lsp_extensions.nvim"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/lsp_extensions.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  ["markdown-preview.nvim"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/markdown-preview.nvim"
  },
  neogit = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/neogit"
  },
  ["nlua.nvim"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/nlua.nvim"
  },
  ["nvcode-color-schemes.vim"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/nvcode-color-schemes.vim"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspinstall"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/nvim-lspinstall"
  },
  ["nvim-luadev"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/nvim-luadev"
  },
  ["nvim-peekup"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/nvim-peekup"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["poet-v"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/poet-v"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["splitjoin.vim"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/splitjoin.vim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["vim-cmake"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/vim-cmake"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-go"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/vim-go"
  },
  ["vim-lookup"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/vim-lookup"
  },
  ["vim-prettier"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/vim-prettier"
  },
  ["vim-startuptime"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/vim-startuptime"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vlog.nvim"] = {
    loaded = true,
    path = "/home/viniciusmoraes/.local/share/nvim/site/pack/packer/start/vlog.nvim"
  }
}

time([[Defining packer_plugins]], false)
if should_profile then save_profiles() end

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
