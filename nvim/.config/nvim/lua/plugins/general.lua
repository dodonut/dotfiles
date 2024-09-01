return {
    { 'numToStr/Comment.nvim', opts = {} },
    'tpope/vim-surround',
    'tpope/vim-sleuth',
    'junegunn/vim-easy-align',
    'LintaoAmons/scratch.nvim',
    -- essa config caga no setup das lsp
    -- {
    --     "LazyVim/LazyVim",
    --     opts = {
    --         colorscheme = "tokyonight",
    --     },
    -- },
    -- homepage, caga no telescope
    -- { import = "lazyvim.plugins.extras.ui.mini-starter" },

    require 'vm.autoformat',
}
