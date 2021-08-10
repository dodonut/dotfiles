return require("packer").startup({
	function(use) -- plug manager
		use("wbthomason/packer.nvim")
		-- colorschemd
		-- use 'morhetz/gruvbox'
		-- auto pairs
		use("jiangmiao/auto-pairs")
		--use 'windwp/nvim-autopairs'

		-- foldmethods
		use("tmhedberg/SimpylFold")
		-- statusline
		use("hoob3rt/lualine.nvim")

		-- lsp
		use("neovim/nvim-lspconfig")
		use("kabouzeid/nvim-lspinstall")
		-- improve lsp
		use("glepnir/lspsaga.nvim")
		-- colors for lsp errors
		use("folke/lsp-colors.nvim")
		-- completion
		use("hrsh7th/nvim-compe")

		-- lsp for java
		use("mfussenegger/nvim-jdtls")
		-- ultisnips
		use("sirver/UltiSnips")
		-- Easily comment out lines or objects
		use("tpope/vim-commentary")
		-- Surround text objects easily
		use("tpope/vim-surround")
		--git plugin
		use({ "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" })

		-- diffview for better diff on commit
		use("sindrets/diffview.nvim")
		-- signs for git hunks
		use("lewis6991/gitsigns.nvim")
		-- colors
		use("christianchiarulli/nvcode-color-schemes.vim")

		--fzf comparizon
		use({ "junegunn/fzf.vim", requires = "junegunn/fzf", run = "fzf#install()" })
		-- help char for end of line and blank spaces
		use("tjdevries/cyclist.vim")

		--lua
		use("rafcamlet/nvim-luapad")
		use("norcalli/nvim_utils")
		use("tjdevries/nlua.nvim")
		use("euclidianAce/BetterLua.vim")

		use({ "fszymanski/fzf-quickfix", run = { "Quickfix" } })

		--tree sitter
		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
		})

		-- use({
		-- 	"lambdalisue/fern.vim",
		-- 	requires = {
		-- 		"antoinemadec/FixCursorHold.nvim",
		-- 		"lambdalisue/fern-renderer-nerdfont.vim",
		-- 		"lambdalisue/fern-git-status.vim",
		-- 		"lambdalisue/fern-hijack.vim",
		-- 	},
		-- })
		-- nerd tree
		-- use({ "preservim/nerdtree", requires = "ryanoasis/vim-devicons" })

		-- tree
		use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })

		-- use({
		-- 	"nvim-telescope/telescope.nvim",
		-- 	requires = {
		-- 		{ "nvim-lua/popup.nvim" },
		-- 		{ "nvim-lua/plenary.nvim" },
		-- 		{ "nvim-telescope/telescope-fzy-native.nvim" },
		-- 	},
		-- })

		-- testing
		use({ "vim-test/vim-test" })

		-- pasting history
		-- use 'svermeulen/vim-yoink'

		use({
			"RishabhRD/nvim-lsputils",
			requires = { "RishabhRD/popfix" },
		})
		-- cheat.sh nvim
		use({
			"RishabhRD/nvim-cheat.sh",
			requires = { "RishabhRD/popfix" },
		})

        use 'junegunn/vim-easy-align'
	end,
})
