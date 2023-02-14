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
        let message=input("Message > ")
        silent execute "!git add $(git rev-parse --show-toplevel)"
        silent execute "G commit -m " . message
        "silent execute "!git push -u origin " . system('git branch | grep \*')[2:-2]
        redraw
        echo "Done!"
    ]])
end

function M.fugitive2()
    local message = vim.fn.input("Message > ")
    local branch = vim.fn.system("git branch | grep \\*")
    vim.fn.system("git add $(git rev-parse --show-toplevel)")
    vim.fn.system("git commit -m " .. message)
    vim.fn.system("git push -u origin " .. string.sub(branch, 2, -2))

    vim.api.nvim_exec("redraw", false)
    print("Done!")
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


function M.map(s, lhs, rhs, desc)
	-- get the extra options
	local opts = { noremap = true, desc = desc }
	-- basic support for buffer-scoped keybindings
	vim.keymap.set(s, lhs, rhs, opts)
end

return M
