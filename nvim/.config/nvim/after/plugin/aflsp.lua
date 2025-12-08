vim.diagnostic.config({
	virtual_text = {
		prefix = "●", -- opcional
		spacing = 2,
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client == nil then
			return
		end

		-- Disable semantic highlights
		client.server_capabilities.semanticTokensProvider = nil

		local opts = { buffer = event.buf }
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "gh", vim.lsp.buf.hover, { desc = "[g]oto [h]over Documentation'" })
		vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "[g]oto [d]efinition" })
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "[g]oto [d]eclaration" })
		vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "[g]oto [i]mplementation" })
		vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "[g]oto [r]eferences" })
		vim.keymap.set("n", "gs", builtin.lsp_workspace_symbols, { desc = "[g]oto [s]ymbols" })
		vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { desc = "refactor rename" })
		vim.keymap.set({ "n", "x" }, "<c-f>", function()
			vim.lsp.buf.format({ bufnr = event.buf })
			vim.cmd("write")
		end, { desc = "format and save" })
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[c]ode [a]ctions" })
		vim.keymap.set(
			"n",
			"]d",
			"<cmd>lua vim.diagnostic.jump({count=1, float=true})<cr>",
			{ desc = "prev diagnostic" }
		)
		vim.keymap.set(
			"n",
			"[d",
			"<cmd>lua vim.diagnostic.jump({count=-1, float=true})<cr>",
			{ desc = "next diagnostic" }
		)
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	callback = function()
		local jdtls = require("jdtls")
		local root = jdtls.setup.find_root({ "pom.xml", "build.gradle", ".git" })
		if not root then
			return
		end

		-- evita reinicializar o servidor
		if vim.g.jdtls_running_for_root == root then
			return
		end
		vim.g.jdtls_running_for_root = root

		require("config.jdtls").setup_jdtls()
	end,
})

vim.api.nvim_create_user_command("EcologRefreshMine", function()
  local ok, ecolog = pcall(require, "ecolog")
  if not ok then
    vim.notify("ecolog.nvim não encontrado", vim.log.levels.ERROR)
    return
  end

  local vars = ecolog.get_env_vars()
  if not vars then
    vim.notify("Nenhuma variável encontrada pelo ecolog", vim.log.levels.WARN)
    return
  end

  for name, data in pairs(vars) do
    -- data.value é a versão já convertida (string, number, bool)
    local val = data.value

    -- converter número ou boolean pra string, porque vim.env exige string
    if type(val) ~= "string" then
      val = tostring(val)
    end

    vim.env[name] = val
  end

  vim.notify("Ecolog: variáveis carregadas para vim.env!", vim.log.levels.INFO)
end, {})

