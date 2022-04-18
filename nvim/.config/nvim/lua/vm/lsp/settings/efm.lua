
local util = require("lspconfig.util")
local root_dir = function(fname)
	return util.root_pattern(".git")(fname) or vim.fn.getcwd()
end
return {
		settings = {
			root_dir = root_dir,
			languages = {
				sh = {
					lintCommand = "shellcheck -f gcc -x -",
					lintStdin = true,
					lintFormats = { "%f=%l:%c: %trror: %m", "%f=%l:%c: %tarning: %m", "%f=%l:%c: %tote: %m" },
				},
			},
		},
	}
