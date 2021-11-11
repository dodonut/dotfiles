local M = {}

function M.setup()
	local on_attach = require("vm.lsp").on_attach
	local custom_cap = require("vm.lsp").capabilities
	local root_markers = { "gradlew" }
	local root_dir = require("jdtls.setup").find_root(root_markers)
	local home = os.getenv("HOME")

	-- local capabilities = {
	--     workspace = {
	--         configuration = true
	--     },
	--     textDocument = {
	--         completion = {
	--             completionItem = {
	--                 snippetSupport = true
	--             }
	--         }
	--     }
	-- }

	local workspace_folder = home .. "/.workspace-" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
	local config = {
		flags = {
			allow_incremental_sync = true,
		},
		capabilities = custom_cap,
		on_attach = on_attach,
	}

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
		},
	}


	config.cmd = { "java-lsp.sh", workspace_folder }
	config.on_init = function(client, _)
		vim.notify("workspace/didChangeConfiguration", { settings = config.settings })
	end
    -- if root_dir ~= nil then
		-- config.settings['java.format.settings.url'] = root_dir .. '/code_style.xml',
		-- config.settings['java.format.settings.profile'] = "WorkStyle",
    -- end

	-- local jar_patterns = {
	--     '/dev/microsoft/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar',
	--     '/dev/dgileadi/vscode-java-decompiler/server/*.jar',
	--     '/dev/microsoft/vscode-java-test/server/*.jar',
	-- }

	-- local bundles = {}
	-- for _, jar_pattern in ipairs(jar_patterns) do
	--   for _, bundle in ipairs(vim.split(vim.fn.glob(home .. jar_pattern), '\n')) do
	--     if not vim.endswith(bundle, 'com.microsoft.java.test.runner.jar') then
	--       table.insert(bundles, bundle)
	--     end
	--   end
	-- end

	local extendedClientCapabilities = require("jdtls").extendedClientCapabilities
	extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
	config.init_options = {
		-- bundles = bundles;
		extendedClientCapabilities = extendedClientCapabilities,
	}

	-- UI
	-- local finders = require("telescope.finders")
	-- local sorters = require("telescope.sorters")
	-- local actions = require("telescope.actions")
	-- local pickers = require("telescope.pickers")
	-- require("jdtls.ui").pick_one_async = function(items, prompt, label_fn, cb)
	-- 	local opts = {}
	-- 	pickers.new(opts, {
	-- 		prompt_title = prompt,
	-- 		finder = finders.new_table({
	-- 			results = items,
	-- 			entry_maker = function(entry)
	-- 				return {
	-- 					value = entry,
	-- 					display = label_fn(entry),
	-- 					ordinal = label_fn(entry),
	-- 				}
	-- 			end,
	-- 		}),
	-- 		sorter = sorters.get_generic_fuzzy_sorter(),
	-- 		attach_mappings = function(prompt_bufnr)
	-- 			actions.goto_file_selection_edit:replace(function()
	-- 				local selection = actions.get_selected_entry(prompt_bufnr)
	-- 				actions.close(prompt_bufnr)

	-- 				cb(selection.value)
	-- 			end)

	-- 			return true
	-- 		end,
	-- 	}):find()
    -- end

    vim.cmd[[
    command! -buffer JdtCompile lua require('jdtls').compile()
    command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()
    command! -buffer JdtJol lua require('jdtls').jol()
    command! -buffer JdtBytecode lua require('jdtls').javap()
    command! -buffer JdtJshell lua require('jdtls').jshell()
    ]]
	-- Server
	require("jdtls").start_or_attach(config)
end

return M
