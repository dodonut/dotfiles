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

function Inoremap(lhs, rhs, opts, bufnr)
    local _opts = opts or { noremap = true, silent = true }
    local _bufnr = bufnr or vim.fn.bufnr()
    vim.api.nvim_buf_set_keymap(_bufnr, "i", lhs, rhs, _opts)
end

function Nnoremap(lhs, rhs, opts, bufnr)
    local _opts = opts or { noremap = true, silent = true }
    local _bufnr = bufnr or vim.fn.bufnr()
    vim.api.nvim_buf_set_keymap(_bufnr, "n", lhs, rhs, _opts)
end


Map = function(s, lhs, rhs, desc)
	-- get the extra options
	local opts = { noremap = true, desc = desc }
	-- basic support for buffer-scoped keybindings
	vim.keymap.set(s, lhs, rhs, opts)
end
