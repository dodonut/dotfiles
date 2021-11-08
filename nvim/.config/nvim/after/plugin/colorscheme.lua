local material = require("material")
material.setup({
	borders = true,
})

vim.g.material_style = "darker"
-- avalailable colors
-- darker
-- lighter
-- oceanic
-- palenight
-- deep ocean

vim.api.nvim_command("colorscheme material")
