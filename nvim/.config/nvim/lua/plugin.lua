return require('packer').startup {
    function(use)
        -- plug manager
        use 'wbthomason/packer.nvim'
        -- colorschemd
        use 'morhetz/gruvbox'
        -- auto pairs
        use 'jiangmiao/auto-pairs'
        --use 'windwp/nvim-autopairs'

        -- statusline
        use 'hoob3rt/lualine.nvim'

        -- lsp
        use 'neovim/nvim-lspconfig'
        use 'kabouzeid/nvim-lspinstall'
        -- improve lsp
        use 'glepnir/lspsaga.nvim'
        -- colors for lsp errors
        use 'folke/lsp-colors.nvim'
        -- completion
        use 'hrsh7th/nvim-compe'

        -- ultisnips
        use 'sirver/UltiSnips'
        -- Easily comment out lines or objects
        use 'tpope/vim-commentary'
        -- Surround text objects easily
        use 'tpope/vim-surround'
        --git plugin
        use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
        -- signs for git hunks
        use 'lewis6991/gitsigns.nvim'
        -- colors
        use 'christianchiarulli/nvcode-color-schemes.vim'

        -- help char for end of line and blank spaces
        use 'tjdevries/cyclist.vim'


        --lua 
        use 'rafcamlet/nvim-luapad'
        use 'norcalli/nvim_utils'
        use 'tjdevries/nlua.nvim'
        use 'euclidianAce/BetterLua.vim'

        --tree sitter
        use {
                'nvim-treesitter/nvim-treesitter',
                run = ':TSUpdate'
            }

        -- icons
        use 'kyazdani42/nvim-web-devicons'
        -- tree
        use 'kyazdani42/nvim-tree.lua'

        use {
          'nvim-telescope/telescope.nvim',
          requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
        }

        -- cheat.sh nvim
        use{  
            'RishabhRD/nvim-cheat.sh',
            requires = {'RishabhRD/popfix'}        
    }
    end

}
