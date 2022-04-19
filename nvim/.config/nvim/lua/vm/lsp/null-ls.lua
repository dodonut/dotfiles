local ok, nullls = pcall(require, 'null-ls')

if not ok then
    return
end

local f = nullls.builtins.formatting
local ca = nullls.builtins.code_actions
local d = nullls.builtins.diagnostics
local helpers = require('null-ls.helpers')

local shellcheck_lint = {
    method = nullls.methods.DIAGNOSTICS,
    filetypes = { "sh" },
    generator = nullls.generator({
        command = "shellcheck",
        args = {  "--format", "json", "-x", "-", vim.fn.expand('%') },
        to_stdin = true,
        from_stderr = true,
                -- choose an output format (raw, json, or line)
                format = "line",
                check_exit_code = function(code, stderr)
                    local success = code <= 1

                    if not success then
                      -- can be noisy for things that run often (e.g. diagnostics), but can
                      -- be useful for things that run on demand (e.g. formatting)
                      print(stderr)
                    end
                    print('code',code,'stderr', stderr)

                    return success
                end,
                -- use helpers to parse the output from string matchers,
                -- or parse it manually with a function
                on_output = helpers.diagnostics.from_patterns({
                    {
                        pattern = [[:(%d+):(%d+) [%w-/]+ (.*)]],
                        groups = { "row", "col", "message" },
                    },
                    {
                        pattern = [[:(%d+) [%w-/]+ (.*)]],
                        groups = { "row", "message" },
                    },
            })
    }),
}

nullls.setup({
    sources = {
        f.stylua,
        ca.shellcheck,
        d.shellcheck,
    }
})

-- nullls.register(shellcheck_lint)
