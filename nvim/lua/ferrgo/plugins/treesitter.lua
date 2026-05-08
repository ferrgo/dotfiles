return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local parsers = {
            "vimdoc",
            "javascript",
            "typescript",
            "tsx",
            "lua",
            "jsdoc",
            "bash",
            "http",
            "json",
            "markdown",
            "markdown_inline",
            "diff",
        }

        require("nvim-treesitter").install(parsers)

        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                if not pcall(vim.treesitter.start, args.buf) then return end
                vim.wo[0][0].foldmethod = "expr"
                vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
                vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
