local M = {}
function M:Exec_on_terminal(cmd, cwd)
	-- -- abre split vertical, diminui o tamanho e inicia como terminal
	vim.cmd("vsplit | vert resize 100 | terminal")
	vim.cmd("startinsert")
	-- pega o channel ID do terminal recém-aberto
	local term_chan = vim.b.terminal_job_id
	-- define o cwd (se você quiser)
	if root then
		vim.fn.chansend(term_chan, "cd " .. cwd .. "\n")
	end
	-- executa o comando
	vim.fn.chansend(term_chan, cmd .. "\n")
end

function M:Find_root_dir(start_dir)
	local uv = vim.loop
	local markers = { ".git", "mvnw", "gradlew", "pom.xml" }

	-- Se não passar nada, usar o diretório do arquivo atual
	start_dir = start_dir or vim.fn.expand("%:p:h")

	local function exists(path)
		return uv.fs_stat(path) ~= nil
	end

	local dir = start_dir

	while dir do
		for _, marker in ipairs(markers) do
			if exists(dir .. "/" .. marker) then
				return dir
			end
		end

		-- sobe um diretório
		local parent = uv.fs_realpath(dir .. "/..")
		if parent == dir then
			-- chegou no root da FS
			return nil
		end
		dir = parent
	end
	return nil
end

-- get the method name when cursor is on the function or inside the function
function M:Get_method_name_on_cursor(filetype)
	local ts = vim.treesitter
	local parser = ts.get_parser(0, filetype)
	local tree = parser:parse()[1]
	local root = tree:root()

	local cursor_row, cursor_col = unpack(vim.api.nvim_win_get_cursor(0))
	cursor_row = cursor_row - 1

	local node = root:named_descendant_for_range(cursor_row, cursor_col, cursor_row, cursor_col)

	while node do
		if node:type() == "method_declaration" then
			local id = node:field("name")[1]
			if id then
				return vim.treesitter.get_node_text(id, 0)
			end
		end
		node = node:parent()
	end

	return nil
end

return M
