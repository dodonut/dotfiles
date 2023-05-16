-- autoinstall
local id = vim.api.nvim_create_augroup("packer_auto_update", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", { pattern = "plugins.lua", command = "source <afile>", group = id })

local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end
-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

return packer.startup(function(use) -- plug manager
	use("wbthomason/packer.nvim")
	-- auto pairs
	-- use("jiangmiao/auto-pairs")
	use({ "windwp/nvim-autopairs" })
	-- statusline
	use("hoob3rt/lualine.nvim")

	-- lsp
	use({
		"neovim/nvim-lspconfig",
		requires = {
			-- "williamboman/nvim-lsp-installer",
            "williamboman/mason-lspconfig.nvim",
			"ray-x/lsp_signature.nvim",
			"folke/lsp-colors.nvim",
			"onsails/lspkind-nvim",
		},
	})
    use {
        "williamboman/mason.nvim",
        run = ":MasonUpdate"
    }

	use("folke/tokyonight.nvim")
	---- completion
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
	})
	use({ "voldikss/vim-floaterm" })
	-- Easily comment out lines or objects
	use("tpope/vim-commentary")
	---- Surround text objects easily
	use("tpope/vim-surround")

	--git plugin
	--neogit slowing neovim down -- figure out why
	use({ "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" })
	use("tpope/vim-fugitive")

	-- signs for git hunks
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	})

	-- colors
	use("marko-cerovac/material.nvim")

	use("tjdevries/cyclist.vim")

	--lua
	use("rafcamlet/nvim-luapad")
	use({ "tjdevries/nlua.nvim" })
	use("norcalli/nvim_utils")
	use({ "euclidianAce/BetterLua.vim" })

	use({ "benmills/vim-golang-alternate" })
	--tree sitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})

	use({
		"rktjmp/highlight-current-n.nvim",
		run = function()
			require("highlight-current-n").setup({ highlight_group = "IncSearch" })
		end,
	})

	-- tree

	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	})

	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
		},
	})

	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	-- look into how to make it work
	--debugger
	use({
		"mfussenegger/nvim-jdtls",
		requires = {},
	})

	use({
		"mfussenegger/nvim-dap",
		requires = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-telescope/telescope-dap.nvim",
			"leoluz/nvim-dap-go",
			"rcarriga/cmp-dap",
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

	use({ "kevinhwang91/nvim-bqf", ft = "qf" })

	use("junegunn/vim-easy-align")

	-- notifications
	use("rcarriga/nvim-notify")

	-- Better profiling output for startup.
	use({
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
	})

	--async run
	use("tpope/vim-dispatch")
	use("tpope/vim-dotenv")

	-- for bash script, use the shellcheck cli to give the diagnostics
	use("mattn/efm-langserver")
	----useful functions
	use("tpope/vim-scriptease")

	use({
		"sudormrfbin/cheatsheet.nvim",

		requires = {
			{ "nvim-telescope/telescope.nvim" },
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
		},
	})

	use({ "jose-elias-alvarez/null-ls.nvim" })
	use({ "hashivim/vim-terraform" })
	-- use { 'brooth/far.vim' }
	use({ "nvim-pack/nvim-spectre" })
	-- Automatically set up your configuration after cloning packer.nvim
	use({
		"catppuccin/nvim",
		as = "catppuccin",
	}) -- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end

    use({"L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*", requires = {'saadparwaiz1/cmp_luasnip'}})
end)
