local a = "test"

function GlobFunc()
    print('teste')
	local mk_params = vim.lsp.util.make_position_params()
	-- P(params)
	local range = {
		start = {
			line = 1,
			character = 10,
		},
	}
	range["end"] = {
		line = 1,
		character = 100,
	}
	local param = {
		uri = mk_params.textDocument.uri,
		diagnostics = {
			{ range = range, message = "esse eh um textinho" },
		},
	}
    mk_params.uri = param.uri
    mk_params.diagnostics = param.diagnostics

    -- P(param)
	-- || {
	-- ||   position = {
	-- ||     character = 2,
	-- ||     line = 5
	-- ||   },
	-- ||   textDocument = {
	-- ||     uri = "file:///home/tqi_vsousa/dotfiles/nvim/.config/nvim/scratch/testdiagnostic.lua"
	-- ||   }
	-- || }
	vim.lsp.buf_request(0, "textDocument/publishDiagnostics", mk_params, function(err, result, ctx, config)
        print('test')
        print(err, result, ctx, config)
	end)
end
