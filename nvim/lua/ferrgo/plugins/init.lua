return {
    { import = "ferrgo.plugins.lsp" },
    { import = "ferrgo.plugins.learning-tools" },
    {
        "github/copilot.vim",
        enabled = false
    },
    {
        "prichrd/netrw.nvim",
        config = function()
            require("netrw").setup({
                use_devicons = true,
                icons = {
                    symlink = "", -- Symlink icon (directory and file)
                    directory = "", -- Directory icon
                    file = "", -- File icon
                },
            })
        end,
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    {
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {},
        -- Optional dependencies
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
        -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
        config = function()
            local oil = require("oil")
            oil.setup({
                default_file_explorer = true,
                keymaps = {
                    ["<C-c>"] = false, -- disable the default mapping
                    ["<ESC>"] = "actions.close",
                },
                columns = {
                    "icon",
                    "permissions",
                    "size",
                    "mtime",
                },
                float = {
                    max_width = 100,
                    max_height = 20,
                    show_hidden = true
                },
                view_options = {
                    show_hidden = true
                }
            })
            vim.keymap.set("n", "<leader>ll", function() oil.open_float() end, { desc = "Open Oil (floating)" })
            vim.keymap.set(
                "n",
                "<leader>df",
                function()
                    -- 1. Grab the value from the environment (or use a default)
                    -- TODO: GET Dotfiles_dir exported for env
                    local full = os.getenv("DOTFILES_DIR") or os.getenv("MYVIMRC") or ""
                    -- 2. Match “everything up to the last two path segments”
                    --    (.*)  ← as much as possible
                    --    /[^/]+ ← one “/segment”
                    --    /[^/]+$ ← another “/segment” at end of string
                    local prefix = full:match("(.*)/[^/]+/[^/]+$")
                    oil.open_float(prefix)
                end,
                { desc = "Open Oil (floating) on Dotfiles" }
            )
            vim.keymap.set("n", "<leader>ls", "<Cmd>Oil<CR>", { desc = "Open Oil" })
        end
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },
}
