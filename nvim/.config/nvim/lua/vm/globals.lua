
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

MyFormatting = function ()
	if vim.fn.expand('%:e') == 'lua' then
		vim.cmd "silent execute '!stylua %'"
		if vim.v.shell_error ~= 0 then
			vim.notify('Fail to format')
		end
	else
		vim.lsp.buf.format()
	end
end

SelectJavaProfile = function ()
    local popup = require('popup')
    local title = 'Select the java profile'
    local len = string.len(title)
    popup.create({'dev', 'qa', 'quit'}, {
        title = title,
        line = vim.api.nvim_win_get_height(0)/2,
        col = vim.api.nvim_win_get_width(0)/2-len,
        enter = true,
        cursorline = true,
        padding = {0,len/2,0,len/2},
        border = {1,1,1,1},
        border_char = {'+'},
        callback = function (_, sel)
            sel = string.gsub(sel, "%s+", "")
            if sel == 'quit' then
                return
            end
            local value = "let $SPRING_PROFILES_ACTIVE=" .. sel
            vim.api.nvim_command(value)
        end
    })
end


