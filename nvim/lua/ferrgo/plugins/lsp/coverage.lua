return {
    {
        "andythigpen/nvim-coverage",
        version = "*",
        config = function()
            require("coverage").setup({
                auto_reload = true,
                signs = {
                    priority = 1
                }
            })
        end,
    },
}
