local util = require("utils.utils")

local function java_locations(callback, args)
	local bufnr = vim.api.nvim_get_current_buf()
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
			callback(nil, args)
		else
			local java_name = result["org.eclipse.jdt.core.compiler.source"]
			local java_home = result["org.eclipse.jdt.ls.core.vm.location"]
			callback({ java_name = java_name, java_home = java_home }, args)
		end
	end)
end

local function get_project_wrapper(root)
	local Path = require("plenary.path")

	local mvnw = Path:new(root .. "/mvnw")
	local gradlew = Path:new(root .. "/gradlew")
	local pom = Path:new(root .. "/pom.xml")
	local gradle_build = Path:new(root .. "/build.gradle")

	local wrapper = nil

	if mvnw:exists() then
		return "./mvnw"
	elseif gradlew:exists() then
		return "./gradlew"
	else
		vim.notify("Wrapper maven ou gradlew não encontrado", vim.log.levels.ERROR)
		return nil
	end
end

local function execute_tests(t, args)
	local java_name = t.java_name
	local java_home = t.java_home
	local root = util:Find_root_dir()
	if root == nil or root == "" then
		vim.notify("Não foi possível encontrar o root do projeto", vim.log.levels.ERROR)
		return
	end

	if not java_home then
		vim.notify("Não foi possível detectar o runtime do jdtls", vim.log.levels.WARN)
		return
	end

	local wrapper = get_project_wrapper(root)

	vim.notify_once("Java: " .. java_name .. " | type: " .. wrapper, vim.log.levels.INFO)
	local cmd = "JAVA_HOME=" .. java_home .. " " .. wrapper .. " " .. table.concat(args, " ")

	util:Exec_on_terminal(cmd, root)

	--VERY GOOD, but its better to run on terminal if it takes too long
	-- local Job = require("plenary.job")
	-- Job:new({
	-- 	command = wrapper,
	-- 	cwd = root,
	-- 	args = args,
	-- 	env = {
	-- 		JAVA_HOME = java_home,
	-- 		PATH = java_home .. "/bin:" .. os.getenv("PATH"),
	-- 	},
	-- 	on_exit = function(j, code)
	-- 		if code == 0 then
	-- 			vim.notify("✔ Testes ok!")
	-- 		else
	-- 			vim.notify("❌ Erro nos testes")
	-- 			vim.print(table.concat(j:stderr_result(), "\n"))
	-- 		end
	-- 	end,
	-- }):start()
end

local function get_class_path()
	local path = vim.fn.expand("%:p")
	return path:gsub(".*/src/test/java/", ""):gsub("/", "."):gsub("%.java$", "")
end

vim.api.nvim_buf_create_user_command(0, "RunTests", function()
	java_locations(execute_tests, { "clean", "test" })
end, { desc = "Executa todos os testes do projeto Java" })

vim.api.nvim_buf_create_user_command(0, "RunTestsClass", function()
	local classpath = get_class_path()
	java_locations(execute_tests, { "clean", "test", "--tests", classpath })
end, { desc = "Executa todos os testes do projeto Java" })

vim.api.nvim_buf_create_user_command(0, "RunTestsMethod", function()
	local classpath = get_class_path()
	local method_name = util:Get_method_name_on_cursor("java")
	assert(method_name, "Could not get the method name")
	local concat = classpath .. "." .. method_name

	java_locations(execute_tests, { "clean", "test", "--tests", concat })
end, { desc = "Executa todos os testes do projeto Java" })

vim.keymap.set(
	"n",
	"<leader>JTT",
	"<cmd>RunTests<cr>",
	{ noremap = true, desc = "[J]ava [T]erminal [T]est all project" }
)

vim.keymap.set(
	"n",
	"<leader>JTt",
	"<cmd>RunTestsClass<cr>",
	{ noremap = true, desc = "[J]ava [T]erminal [T]est class" }
)

vim.keymap.set(
	"n",
	"<leader>JTm",
	"<cmd>RunTestsMethod<cr>",
	{ noremap = true, desc = "[J]ava [T]erminal [T]est method" }
)
