return require("packer").startup({
	function(use) -- plug manager
		use("wbthomason/packer.nvim")
		-- auto pairs
		use("jiangmiao/auto-pairs")
		-- foldmethods
		use("tmhedberg/SimpylFold")
		-- statusline
		use("hoob3rt/lualine.nvim")

		-- lsp
		use({
			"neovim/nvim-lspconfig",
			requires = {
				"williamboman/nvim-lsp-installer",
				"ray-x/lsp_signature.nvim",
				"folke/lsp-colors.nvim",
				"onsails/lspkind-nvim",
			},
		})

		-- improve lsp
		-- use("glepnir/lspsaga.nvim")
		-- colors for lsp errors
		--
		use("folke/tokyonight.nvim")
		---- completion
		use({
			"hrsh7th/cmp-nvim-lsp",
			requires = {
				"hrsh7th/cmp-buffer",
				"hrsh7th/nvim-cmp",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-nvim-lua",
				"quangnguyen30192/cmp-nvim-ultisnips",
			},
		})
		use({ "voldikss/vim-floaterm", config = {
			vim.cmd([[ nnoremap <S-t> :FloatermNew<cr>]]),
		} })
		-- ultisnips
		use({ "sirver/UltiSnips", requires = "honza/vim-snippets" })
		-- Easily comment out lines or objects
		use("tpope/vim-commentary")
		---- Surround text objects easily
		use("tpope/vim-surround")

		--git plugin
		--neogit slowing neovim down -- figure out why
		-- use({ "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" })
		use("tpope/vim-fugitive")
		use("samoshkin/vim-mergetool")
		use({ "tanvirtin/vgit.nvim" })

		-- diffview for better diff on commit
		use("sindrets/diffview.nvim")
		-- signs for git hunks
		use({
			"lewis6991/gitsigns.nvim",
		})
		-- colors
		--use("marko-cerovac/material.nvim")

		----fzf comparizon
		--use({ "junegunn/fzf.vim", requires = "junegunn/fzf", run = "fzf#install()" })
		-- help char for end of line and blank spaces
		use("tjdevries/cyclist.vim")

		--lua
		use("rafcamlet/nvim-luapad")
		use("norcalli/nvim_utils")

		--tree sitter
		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
		})

		-- tree
		use({
			"kyazdani42/nvim-tree.lua",
			requires = "kyazdani42/nvim-web-devicons",
			config = function()
				require("nvim-tree").setup({})
			end,
		})

		use({
			"nvim-telescope/telescope.nvim",
			requires = {
				"nvim-lua/popup.nvim",
				"nvim-lua/plenary.nvim",
				"fhill2/telescope-ultisnips.nvim",
			},
		})

		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

		-- look into how to make it work
		--debugger
		use({
			"mfussenegger/nvim-jdtls",
			requires = {
				"mfussenegger/nvim-dap",
				"rcarriga/nvim-dap-ui",
				"theHamsta/nvim-dap-virtual-text",
				"nvim-telescope/telescope-dap.nvim",
				"leoluz/nvim-dap-go",
			},
		})

		---- use('romgrk/barbar.nvim')

		-- testing
		use({ "vim-test/vim-test" })

		use({
			"RishabhRD/nvim-lsputils",
			requires = { "RishabhRD/popfix" },
		})
		-- cheat.sh nvim
		use({
			"RishabhRD/nvim-cheat.sh",
			requires = { "RishabhRD/popfix" },
			config = {
				vim.cmd([[  nnoremap <leader>sc :Cheat<cr>]]),
			},
		})

		---- shows all diagnostics across files
		use({
			"folke/trouble.nvim",
			requires = "kyazdani42/nvim-web-devicons",
			config = function()
				require("trouble").setup({
					auto_open = false,
				})
			end,
		})

		--use({ "kevinhwang91/nvim-bqf", ft = "qf" })

		use("junegunn/vim-easy-align")

		-- notifications
		use("rcarriga/nvim-notify")

		---- cursor hold lag and performance bug
		--use({
		--	"antoinemadec/FixCursorHold.nvim",
		--	run = function()
		--		vim.g.curshold_updatime = 1000
		--	end,
		--})

		-- Better profiling output for startup.
		use({
			"dstein64/vim-startuptime",
			cmd = "StartupTime",
		})
		----sql
		--use("tpope/vim-dadbod")
		--use("kristijanhusak/vim-dadbod-completion")
		--use("kristijanhusak/vim-dadbod-ui")
		--use("skywind3000/vim-quickui")

		--async run
		use("tpope/vim-dispatch")
		use("tpope/vim-dotenv")

		-- for bash script, use the shellcheck cli to give the diagnostics
		use("mattn/efm-langserver")
		----useful functions
		--use("tpope/vim-scriptease")

		use({ "hashivim/vim-terraform" })

		use({
			"sudormrfbin/cheatsheet.nvim",

			requires = {
				{ "nvim-telescope/telescope.nvim" },
				{ "nvim-lua/popup.nvim" },
				{ "nvim-lua/plenary.nvim" },
			},
		})
	end,
})
