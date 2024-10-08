local function split(line, sep)
	if sep == nil then
		sep = "\n"
	end

	local t = {}
	for token in string.gmatch(line, "[^%" .. sep .. "]+") do
		table.insert(t, token)
	end
	return t
end
local M = {}

M.sourceFiles = function()
	local prepath = "~/.config/nvim/"
	local directories = {
		tostring(prepath .. "after/plugin/"),
		tostring(prepath .. "lua/vm/"),
		tostring(prepath .. "lua/plugins/"),
		tostring(prepath .. "lua"),
	}
	local sourcedirs = function(dirs)
		for _, i in pairs(dirs) do
			local s = split(vim.fn.globpath(i, "*.*"))
			for _, v in pairs(s) do
				vim.api.nvim_command("source " .. v)
			end
		end
	end
	sourcedirs(directories)
	print("Source success!")
end

return M
