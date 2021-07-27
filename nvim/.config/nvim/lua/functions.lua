

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

local SourceFiles = function()
	local pre = "~/.config/nvim/"
	local dd = {
		tostring(pre .. "after/plugin/"),
		tostring(pre .. "lua/tscope"),
		tostring(pre .. "lua")
	}
	local sourcedirs = function(dirs)
        for _, i in pairs(dirs) do
		    local s = split(vim.fn.globpath(i, "*.*"))
            for _, v in pairs(s) do
                vim.api.nvim_command("source " .. v)
            end
        end
	end
    sourcedirs(dd)
end

return {
	SourceFiles = SourceFiles,
}
