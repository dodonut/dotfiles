local M = {}

function M.execute_buf_command(command, callback)
	vim.lsp.buf_request(0, "workspace/executeCommand", command, function(err, res)
		if callback then
			callback(err, res)
		elseif err then
			print("Execute command failed: " .. err.message)
		end
	end)
end

function M.execute_command(command, callback)
	if type(command) == "string" then
		command = { command = command }
	end

	M.execute_buf_command(command, function(err, res)
		assert(not err, err and (err.message or Log.ins(err)))
		callback(res)
	end)
end

--[[
-- Starts the dubug session and returns the port
--
-- @Param callback {function(port: number)}
--]]
function M.start_debug_session(callback)
	M.execute_command("vscode.java.startDebugSession", callback)
end

--[[
-- Returns all the main classes in the project
--
-- @Param callback {function(main_classes: List<List<String>)}
-- { {
--     filePath = "/home/s1n7ax/Workspace/demo/src/main/java/com/example/demo/DemoApplication.java",
--     mainClass = "com.example.demo.DemoApplication",
--     projectName = "demo"
-- } }
--]]
function M.resolve_main_classes(callback)
	M.execute_command("vscode.java.resolveMainClass", callback)
end

--[[
-- Returns classpath for the given main class
--
-- @Param main_class {string} of which classpath should be returned
-- @Param callback {function(classpath: List<List<String>>)}
-- { {},
-- {
--     "/home/s1n7ax/Workspace/demo/bin/main",
--     "/home/s1n7ax/.gradle/.../spring-boot-starter-web/2.5.4/2bef2cedf/spring-boot-starter-web-2.5.4.jar",
-- }
--]]
function M.resolve_class_path(main_class, project_name, callback)
	M.execute_command({
		command = "vscode.java.resolveClasspath",
		arguments = { main_class, project_name },
	}, callback)
end

--[[
-- Returns list of main class and classpath map
--
-- @Param callback {function(classpaths: List<Map>)}
--]]
function M.resolve_class_paths(callback)
	local classpaths = {}

	local function resolve_all_class_paths(class_iter)
		local class_info = class_iter.next()

		if not class_info then
			return callback(classpaths)
		end

		M.resolve_class_path(class_info.mainClass, class_info.projectName, function(class_path)
			table.insert(classpaths, { class_info = class_info, class_path = class_path })

			resolve_all_class_paths(class_iter)
		end)
	end

	M.resolve_main_classes(function(main_class_info)
		local index = 1

		local main_class_iter = {
			next = function()
				local temp_index = index
				index = index + 1
				return main_class_info[temp_index]
			end,
		}

		resolve_all_class_paths(main_class_iter)
	end)
end

--[[
-- Returns dap java debug configuration
--
-- @Param callback {function(config: Map)}
--]]
function M.get_dap_config(callback)
	-- the call on startDebugSession already return the main classes
	-- change later
	M.resolve_class_paths(function(class_paths_info)
		local conf = {}

		for index, classpath_info in ipairs(class_paths_info) do
			local main_class = classpath_info.class_info.mainClass
			local project_name = classpath_info.class_info.projectName
			local class_paths = classpath_info.class_path

			table.insert(conf, {
				name = string.format("(%d) Launch -> %s -> %s", index, project_name, main_class),
				projectName = project_name,
				mainClass = main_class,
				classPaths = vim.tbl_flatten(class_paths),
				modulePaths = {},
				request = "launch",
				type = "java",
				javaExec = os.getenv("JAVA_HOME") .. "/bin/java",
			})
		end

		callback(conf)
	end)
end

function M.setup()
	local dap = require("dap")
	local on_attach = require("vm.lsp").on_attach
	local custom_cap = require("vm.lsp").capabilities
	local root_markers = { "gradlew", ".git" }
	local root_dir = require("jdtls.setup").find_root(root_markers)
	local home = os.getenv("HOME")

	local workspace_folder = home .. "/.workspace-" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
	local config = {
		flags = {
			allow_incremental_sync = true,
		},
		capabilities = custom_cap,
		on_attach = on_attach,
	}

	local formatpath = function()
		if root_dir == nil then
			return ""
		else
			return root_dir .. "/code_style.xml"
		end
	end

	config.settings = {
		java = {
			signatureHelp = { enabled = true },
			contentProvider = { preferred = "fernflower" },
			completion = {
				favoriteStaticMembers = {
					"org.hamcrest.MatcherAssert.assertThat",
					"org.hamcrest.Matchers.*",
					"org.hamcrest.CoreMatchers.*",
					"org.junit.jupiter.api.Assertions.*",
					"java.util.Objects.requireNonNull",
					"java.util.Objects.requireNonNullElse",
					"org.mockito.Mockito.*",
				},
			},
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
			codeGeneration = {
				toString = {
					template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
				},
			},
			configuration = {
				runtimes = {
					{
						name = "JavaSE-11",
						path = home .. "/.sdkman/candidates/java/11.0.12-open/",
					},
					{
						name = "JavaSE-16",
						path = home .. "/.sdkman/candidates/java/16.0.2-open/",
					},
				},
			},
            -- have to figure it out
			-- format = {
			-- 	settings = {
			-- 		url = formatpath(),
			-- 		profile = "teste",
			-- 	},
			-- },
		},
	}

	config.cmd = { "java-lsp.sh", workspace_folder }
	config.filetypes = { "java" }
	config.on_init = function(client, _)
		vim.notify("workspace/didChangeConfiguration", { settings = config.settings })
	end

	local bundles = {
		-- https://github.com/microsoft/java-debug
		vim.fn.glob(
			"$HOME/dev/source-proj/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
		),
	}

	--https://github.com/microsoft/vscode-java-test
	vim.list_extend(bundles, vim.split(vim.fn.glob("$HOME/dev/source-proj/vscode-java-test/server/*.jar"), "\n"))

	local extendedClientCapabilities = require("jdtls").extendedClientCapabilities
	extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
	config.init_options = {
		bundles = bundles,
		extendedClientCapabilities = extendedClientCapabilities,
	}

	vim.cmd([[
    command! -buffer JdtCompile lua require('jdtls').compile()
    command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()
    command! -buffer JdtJol lua require('jdtls').jol()
    command! -buffer JdtBytecode lua require('jdtls').javap()
    command! -buffer JdtJshell lua require('jdtls').jshell()
    command! -buffer JdtRefreshDebugConfigs lua require('jdtls.dap').setup_dap_main_class_configs()
    command! -buffer JdtTestClass lua require('jdtls').test_class()
    command! -buffer JdtTestNearest lua require('jdtls').test_nearest_method()
    ]])

	dap.adapters.java = function(callback)
		M.start_debug_session(function(port)
			callback({ type = "server", host = "127.0.0.1", port = port })
		end)
	end
	-- Server
	require("jdtls").start_or_attach(config)
end

return M
