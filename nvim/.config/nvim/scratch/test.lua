local a = function()
	local bnr = vim.fn.bufnr("%")
	local ns_id = vim.api.nvim_create_namespace("demo")

	local line_num = 5
	local col_num = 10

	local opts = {
		end_line = 10,
		id = 1,
		virt_text = { { " demo", "ErrorMsg" } },
		virt_text_pos = "eol",
		virt_text_win_col = 50,
	}
	vim.api.nvim_buf_set_extmark(bnr, ns_id, line_num, col_num, opts)
end

a()
