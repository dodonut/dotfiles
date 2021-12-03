local material = require("material")
local colors = require("material.colors")
material.setup({
	contrast = true,
	borders = true,
	custom_highlights = {
		LineNr = { fg = colors.white },
	},
})

vim.g.material_style = "palenight"
-- avalailable colors
-- darker
-- lighter
-- oceanic
-- palenight
-- deep ocean

vim.api.nvim_command("colorscheme material")
