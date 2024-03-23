return {
    "stevearc/conform.nvim",
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                javascript = { "prettier" },
                javascriptreact = { "prettier" },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
            },
        })
        vim.keymap.set({ "n", "v" }, "<leader>ft", function()
            require("conform").format({
                lsp_fallback = true,
                async = false,
            })
        end, { desc = "Format file or range (in visual mode)" })
    end,
}
