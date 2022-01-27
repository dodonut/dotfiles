if not pcall(require, 'material') then
    print 'material not installed'
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
        popup_menu = false
    },
	custom_highlights = {
		LineNr = { fg = colors.white },
        -- Comment= { fg = '#289c43' },
	},
})


-- TODO: TESTE
-- todo: teste
-- Todo: teste
vim.g.material_style = "deep ocean"
-- avalailable colors
-- darker
-- lighter
-- oceanic
-- palenight
-- deep ocean

vim.api.nvim_command("colorscheme material")
