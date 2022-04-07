local id = vim.api.nvim_create_augroup("neomake_hook", { clear = true })
vim.api.nvim_create_autocmd(
	"User",
	{ pattern = "NeomakeJobFinished", command = ":lua require'neomake'.test_finished()", group = id }
)
vim.api.nvim_create_autocmd(
	"User",
	{ pattern = "NeomakeJobStarted", command = ":lua require'neomake'.test_start()", group = id }
)

vim.g.testing_status = ''

local M = {}
M.test_start = function ()
    vim.g.testing_status = 'Test ⌛'
end

M.test_finished = function ()
    local context = vim.g.neomake_hook_context
    if context.jobinfo.exit_code == 1 then
        vim.g.testing_status = 'Test ❌'
    end
end

M.test_status = function ()
    return vim.g.testing_status
end

return M
