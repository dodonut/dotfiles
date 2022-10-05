P = function(v)
	print(vim.inspect(v))
	return v
end

RELOAD = function(...)
	return require("plenary.reload").reload_module(...)
end

R = function(name)
	RELOAD(name)
	return require(name)
end

MyFormatting = function()
	if vim.fn.expand("%:e") == "lua" then
		vim.cmd("silent execute '!stylua %'")
		if vim.v.shell_error ~= 0 then
			vim.notify("Fail to format")
		end
	else
		vim.lsp.buf.format()
	end
end
