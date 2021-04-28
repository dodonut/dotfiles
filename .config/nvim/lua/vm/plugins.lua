return require('packer').startup {
    function(use)
        use 'wbthomason/packer.nvim'
        -- language server install
        use 'kabouzeid/nvim-lspinstall'
        -- ultisnips
        use 'sirver/UltiSnips'
        -- auto pairs
        use 'jiangmiao/auto-pairs'
        -- lua dev
        use 'tjdevries/nlua.nvim'
        -- vim-go
        use 'fatih/vim-go'
        -- logs
        use 'tjdevries/vlog.nvim'
        -- list chars
        use 'tjdevries/cyclist.vim'
        -- statusline
        use 'tjdevries/express_line.nvim'
        -- lua development
        use 'bfredl/nvim-luadev'
        -- lsp
        use 'neovim/nvim-lspconfig'
        -- status on statusline
        use 'wbthomason/lsp-status.nvim'
        -- completion
        use 'hrsh7th/nvim-compe'
        -- improve lsp
        use 'glepnir/lspsaga.nvim'
        -- symbols for completion
        use 'onsails/lspkind-nvim'
        -- extensions for lsp duh
        use 'nvim-lua/lsp_extensions.nvim'
        -- lsp signature
        use 'ray-x/lsp_signature.nvim'
        -- navigation
        -- use {'ray-x/navigator.lua', requires = {'ray-x/guihua.lua', run = 'cd lua/fzy && make'}}
        -- better popup
        use 'nvim-lua/popup.nvim'
        -- useful functions used in some plugins
        use 'nvim-lua/plenary.nvim'
        -- more than a fuzzy finder
        use 'nvim-telescope/telescope.nvim'
        -- measure startup time
        use 'dstein64/vim-startuptime'
        -- show only what you're searching and fold the rest
        -- use 'tjdevries/fold_search.vim'
        -- use 'tjdevries/conf.vim'
        -- trace exceptions on vim
        use 'tweekmonster/exception.vim'
        -- help vim script dev
        use 'mhinz/vim-lookup'
        -- icons
        use 'kyazdani42/nvim-web-devicons'
        -- tree 
        use 'kyazdani42/nvim-tree.lua'
        -- formatter
        use { 'prettier/vim-prettier', run = 'yarn install' }
        -- treesitter
        use {
            'nvim-treesitter/completion-treesitter',
            run = function() vim.cmd [[TSUpdate]] end
          }
        -- Find and replace
        use 'brooth/far.vim'
        -- Easily comment out lines or objects
        use 'tpope/vim-commentary'
        -- one line to multiple and vice-versa
        use 'AndrewRadev/splitjoin.vim'
        -- Surround text objects easily
        use 'tpope/vim-surround'
        -- fugitive
        use 'tpope/vim-fugitive'
        -- signs for git hunks
        use 'lewis6991/gitsigns.nvim'

        -- colors
        use 'christianchiarulli/nvcode-color-schemes.vim'
        use {'nvim-treesitter/nvim-treesitter', run = function() vim.cmd [[TSUpdate]] end}



    end,
    config = {
        _display = {
          open_fn = function(name)
            -- Can only use plenary when we have our plugins.
            --  We can only get plenary when we don't have our plugins ;)
            local ok, float_win = pcall(function()
              return require('plenary.window.float').percentage_range_window(0.8, 0.8)
            end)
    
            if not ok then
              vim.cmd [[65vnew  [packer] ]]
    
              return vim.api.nvim_get_current_win(), vim.api.nvim_get_current_buf()
            end
    
            local bufnr = float_win.bufnr
            local win = float_win.win_id
    
            vim.api.nvim_buf_set_name(bufnr, name)
            vim.api.nvim_win_set_option(win, 'winblend', 10)
    
            return win, bufnr
          end
        },
      }

}
