local material = function()
	if not pcall(require, "material") then
		print("material not installed")
		return
	end

	local material = require("material")
	local colors = require("material.colors")
	material.setup({
		contrast = {
			sidebars = true,
			floating_windows = false,
			line_numbers = false,
			sign_column = false,
			cursor_line = true,
			popup_menu = false,
		},
		custom_highlights = {
			LineNr = { fg = colors.white },
			-- Comment= { fg = '#289c43' },
		},
	})

	-- TODO: TESTE
	-- todo: teste
	-- Todo: teste
	vim.g.material_style = "darker"
	-- avalailable colors
	-- darker
	-- lighter
	-- oceanic
	-- palenight
	-- deep ocean

	vim.api.nvim_command("colorscheme material")
end --

local tokyo = function()
	if not pcall(require, "tokyonight") then
		print("tokyonight not installed")
		return
	end
	vim.cmd "colorscheme tokyonight"
end

tokyo()
