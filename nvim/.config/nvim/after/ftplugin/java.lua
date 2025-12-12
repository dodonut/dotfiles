-- vim.keymap.set(
-- 	"n",
-- 	"<leader>Jto",
-- 	"<cmd>JavaTestViewLastReport<cr>",
-- 	{ noremap = true, desc = "Java [T]est [O]pen last report" }
-- )
--
-- vim.keymap.set(
-- 	"n",
-- 	"<leader>Jtd",
-- 	"<cmd>JavaTestDebugCurrentMethod<cr>",
-- 	{ noremap = true, desc = "Java [T]est [D]ebug" }
-- )
--
-- vim.keymap.set(
-- 	"n",
-- 	"<leader>Jtr",
-- 	"<cmd>JavaTestRunCurrentClass<cr>",
-- 	{ noremap = true, desc = "Java [T]est [R]un for class" }
-- )
--

local function find_root_dir(start_dir)
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

local function execute_tests(java_name, java_path)
	local root = find_root_dir()
	vim.print(root)
	if root == nil or root == "" then
		vim.notify("Não foi possível encontrar o root do projeto", vim.log.levels.ERROR)
		return
	end

	if not java_path then
		vim.notify("Não foi possível detectar o runtime do jdtls", vim.log.levels.WARN)
		return
	end

	local Path = require("plenary.path")

	local mvnw = Path:new(root .. "/mvnw")
	local gradlew = Path:new(root .. "/gradlew")
	local pom = Path:new(root .. "/pom.xml")
	local gradle_build = Path:new(root .. "/build.gradle")

	local type = nil

	if mvnw:exists() then
		type = " ./mvnw"
	elseif gradlew:exists() then
		type = " ./gradlew"
	else
		vim.notify("Wrapper maven ou gradlew não encontrado", vim.log.levels.ERROR)
		return
	end

	vim.notify("Java: " .. java_name .. " | type: " .. type, vim.log.levels.INFO)
	local cmd = "JAVA_HOME=" .. java_path .. type .. " test"

	-- abre split vertical, diminui o tamanho e inicia como terminal
	vim.cmd("vsplit | vert resize 100 | terminal")
	vim.cmd("startinsert")
	-- pega o channel ID do terminal recém-aberto
	local term_chan = vim.b.terminal_job_id
	-- define o cwd (se você quiser)
	if root then
		vim.fn.chansend(term_chan, "cd " .. root .. "\n")
	end
	-- executa o comando
	vim.fn.chansend(term_chan, cmd .. "\n")
end

vim.api.nvim_buf_create_user_command(0, "RunTests", function()
	local bufnr = vim.api.nvim_get_current_buf() -- CHANGE THIS
	local _, client = next(vim.lsp.get_clients({ name = "jdtls" }))
	local command = {
		command = "java.project.getSettings",
		arguments = {
			vim.uri_from_bufnr(bufnr),
			{
				"org.eclipse.jdt.core.compiler.source",
				"org.eclipse.jdt.ls.core.vm.location",
			},
		},
	}
	assert(client, "client is nil")

	client:request("workspace/executeCommand", command, function(err, result)
		if err then
			vim.notify("Não foi possível pegar o runtime", vim.log.levels.ERROR)
			vim.print(err)
			return
		else
			local java_name = result["org.eclipse.jdt.core.compiler.source"]
			local java_path = result["org.eclipse.jdt.ls.core.vm.location"]
			execute_tests(java_name, java_path)
		end
	end)
end, { desc = "Executa todos os testes do projeto Java" })
