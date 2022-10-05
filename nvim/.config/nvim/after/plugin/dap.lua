if not pcall(require, "dap") then
	print("dap not installed")
	return
end

vim.fn.sign_define("DapBreakpoint", { text = "👹", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "🍑", texthl = "", linehl = "", numhl = "" })
-- set signs for debug
--

-- local id = vim.api.nvim_create_augroup("DapRepl", { clear = true })
-- vim.api.nvim_create_autocmd(
-- 	"FileType",
-- 	{ pattern = "dap-repl", command = ":lua require'dap.ext.autocompl'.attach()", group = id }
-- )
-- vim.cmd [[
-- augroup DapRepl
--   au!
--   au FileType dap-repl lua require('dap.ext.autocompl').attach()
-- augroup END
-- ]]

require("dapui").setup({
	icons = { expanded = "▾", collapsed = "▸" },
	mappings = {
		-- Use a table to apply multiple mappings
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
	},
	layouts = {
		{
			elements = {
				"watches",
				"stacks",
				"breakpoints",
				"scopes",
			},
			size = 60,
			position = "left",
		},
		{
			elements = {
				"repl",
				"console",
			},
			size = 10,
			position = "bottom",
		},
	},
	floating = {
		max_height = nil, -- These can be integers or a float between 0 and 1.
		max_width = 0.6, -- Floats will be treated as percentage of your screen.
		border = "single", -- Border style. Can be "single", "double" or "rounded"
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	windows = { indent = 1 },
	render = {
		max_type_length = nil, -- Can be integer or nil.
	},
})

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end


dap.set_log_level("TRACE")
