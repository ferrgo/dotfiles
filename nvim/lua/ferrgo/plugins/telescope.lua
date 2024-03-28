return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-fzf-native.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("telescope").setup({
            pickers = {
                find_files = {
                    hidden = true,
                },
                buffers = {
                    mappings = {
                        n = {
                            ["d"] = "delete_buffer",
                        },
                    },
                },
            },
        })

        local builtin = require("telescope.builtin")
        -- needs fd and fzf to work properly install on system
        vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
        vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
        -- git ls-files respects .gitignore
        vim.keymap.set("n", "<C-p>", builtin.git_files, {})
        -- search input without telescope prompt
        vim.keymap.set("n", "<leader>ps", function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set("n", "<leader>pws", function()
            -- <cword> is the word under the cursor
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set("n", "<leader>pWs", function()
            -- <cWORD> is the WORD - word with symbols - under the cursor
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
    end,
}
