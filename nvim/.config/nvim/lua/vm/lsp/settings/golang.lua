return {
		settings = {
			gopls = {
				codelenses = { test = true },
			},
		},

		flags = {
			debounce_text_changes = 200,
		},
        lsp_cfg = {
            capabilities = require('vm.lsp.handlers').updated_capabilities
        }
	}
