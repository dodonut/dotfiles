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
        }
    }
}
