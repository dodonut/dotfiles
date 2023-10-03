local nullls = require("null-ls")

nullls.setup({
	sources = {
		nullls.builtins.formatting.shfmt,
		nullls.builtins.diagnostics.shellcheck,
		-- nullls.builtins.formatting.google_java_format
	}
})
