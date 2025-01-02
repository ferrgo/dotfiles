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
