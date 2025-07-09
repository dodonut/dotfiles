return {
    "akinsho/bufferline.nvim",
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },
    init = function()
        require('bufferline').setup({
            options = {
                diagnostics = "nvim_lsp"
            }
        })
    end,
    keys = {
        { "<A-n>", "<cmd>BufferLineCycleNext<cr>", desc = "Buffer cycle next" },
        { "<A-p>", "<cmd>BufferLineCyclePrev<cr>", desc = "Buffer cycle prev" },
        { "<A-.>", "<cmd>BufferLineTogglePin<cr>", desc = "Buffer toggle pin" },
        { "<A-q>", "<cmd>bdelete<cr>",             desc = "Buffer remove from list" },
    }
}
