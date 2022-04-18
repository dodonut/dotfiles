if not pcall(require, "nvim-treesitter.configs") then
	print("Not loaded treesitter")
	return
end

require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
		disable = {},
	},
	indent = {
		enable = true,
		disable = {},
	},
    autopairs = {
        enable = true,
    },
	ensure_installed = {
		"java",
		"c",
		"cpp",
        "go"
	},
})

