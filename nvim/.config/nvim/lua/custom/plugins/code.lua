return {
    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
    },
    { 'numToStr/Comment.nvim', opts = {} },
    'tpope/vim-surround',
    'tpope/vim-sleuth',
    "windwp/nvim-autopairs",
    require 'vm.autoformat',
    require 'vm.debug'
}
