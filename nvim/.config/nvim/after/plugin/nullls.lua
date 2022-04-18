local ok, null = pcall(require, 'null-ls')
if not ok then
    print('bosta')
    return
end

null.setup({
    sources = {
        null.builtins.formatting.stylua,
        null.builtins.code_actions.shellcheck
    }
})
