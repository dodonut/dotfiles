return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = true,
    },
    {
        "rcasia/neotest-java",
        ft = "java",
        dependencies = {
            "mfussenegger/nvim-jdtls",
            "mfussenegger/nvim-dap",           -- for the debugger
            "rcarriga/nvim-dap-ui",            -- recommended
            "theHamsta/nvim-dap-virtual-text", -- recommended
        },
        config = function()
            -- override the default keymaps.
            -- needed until neotest-java is integrated in LazyVim
            vim.keymap.set("n", "<leader>Tf", function() require("neotest").run.run(vim.fn.expand("%")) end,
                { desc = "neo[T]est [f]ile" })
            -- run nearest test
            vim.keymap.set("n", "<leader>Tn", function() require("neotest").run.run() end, { desc = "neo[T]est [f]ile" })
            -- debug test file
            vim.keymap.set("n", "<leader>Td", function() require("neotest").run.run({ strategy = "dap" }) end,
                { desc = "neo[T]est [f]ile" })
        end,
    },
}
