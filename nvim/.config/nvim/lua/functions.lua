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
		tostring(prepath .. "lua/vm/lsp"),
		tostring(prepath .. "lua/vm/telescope"),
		tostring(prepath .. "lua/vm"),
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

function M.fugitive()
	--add all files because git add . don't work in the way I open VC
	vim.cmd([[
        silent execute "!git add $(git rev-parse --show-toplevel)"
        silent execute "G commit -m " . input("Message > ")
        silent execute "!git push -u origin " . system('git branch | grep \*')[2:-2]
        redraw
        echo "Done!"
	]])
end

function M.fugitive2()
	-- local message = vim.fn.input("Message > ")
	-- vim.api.nvim_command('silent !git add $(git rev-parse --show-toplevel)')
	-- vim.api.nvim_command('G commit -m ' .. message)
	local branch = vim.api.nvim_exec("!git branch | grep \\*", true)
	vim.api.nvim_exec()
	print("value", branch)
	-- vim.api.nvim_command('!git push -u origin ' .. )
end

-- Synchronously organise (Go) imports.
function M.org_imports_go(timeout_ms)
  local context = { source = { organizeImports = true } }
  vim.validate { context = { context, 't', true } }
  local params = vim.lsp.util.make_range_params()
  params.context = context

  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
  if not result then return end
  for _, v in pairs(result) do
      result = v.result
  end

  if not result then return end
  local edit = result[1].edit.documentChanges
  vim.lsp.util.apply_workspace_edit(edit)
end

function M.list_breakpoints()
    require'dap'.list_breakpoints()
    vim.cmd "TroubleToggle quickfix"
end

return M
