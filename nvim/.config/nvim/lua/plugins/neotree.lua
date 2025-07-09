return
{
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    opts = {
        source_selector = {
            winbar = false,
            statusline = false
        },
        filesystem = {
            use_libuv_file_watcher = true,
            follow_current_file = {
                enabled = true,
                leave_dirs_open = false

            }
        },
        buffers = {
            follow_current_file = {
                enabled = true,
                leave_dirs_open = false
            }
        },
        window = {
            mappings = {
                ["<c-v>"] = "open_vsplit",
                ["<c-x>"] = "open_split",
            }
        }
    },
    keys = {
        { "<localleader>t", ":Neotree filesystem reveal right toggle<cr>", "[T]ree reveal" }
    }
}
