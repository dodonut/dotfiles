return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "rcasia/neotest-java",
      "nvim-neotest/neotest-vim-test"
    },
    -- does not work on multimodule project yet
    -- config = function()
    --   require("neotest").setup({
    --     adapters = {
    --       require("neotest-java")({
    --         ignore_wrapper = false,
    --         project_root = function()
    --           return vim.fn.getcwd()
    --         end
    --       }),
    --       require("neotest-vim-test")({
    --         ignore_file_types = { "python", "vim", "lua" },
    --       }),
    --     },
    --   })
    -- end
  },
}
