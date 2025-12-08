return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },

    opts = {
        -- Opcional: barra para trocar filesystem/buffers/git
        source_selector = {
            winbar = false,
            statusline = false,
        },

        filesystem = {
            use_libuv_file_watcher = true,
            filtered_items = {
                visible = false, -- mostrar ocultos só com toggle
                hide_dotfiles = true,
                hide_gitignored = true,
                hide_by_name = { "node_modules", "target", ".idea", ".vscode" },
            },

            follow_current_file = {
                enabled = true,
                leave_dirs_open = false,
            },
        },

        buffers = {
            follow_current_file = { enabled = true, leave_dirs_open = false },
        },

        git_status = {
            async = true,
        },

        window = {
            mappings = {
                ["<c-v>"] = "open_vsplit",
                ["<c-x>"] = "open_split",

                -- Qualidade de vida
                ["h"] = "close_node",
                ["l"] = "open",
                ["H"] = "toggle_hidden",
            },
        },

        -- Fecha o Neo-tree se for a única janela aberta
        close_if_last_window = true,
    },

    keys = {
        {
            "<localleader>t",
            "<cmd>Neotree toggle reveal<cr>",
            desc = "[T]ree reveal"
        },
    },
}

