return {
    {
        "schrieveslaach/sonarlint.nvim",
        url = "https://gitlab.com/schrieveslaach/sonarlint.nvim.git",
        lazy = false,
        enabled = false,
        config = function()
            require("sonarlint").setup({
                server = {
                    cmd = {
                        "sonarlint-language-server",
                        -- Ensure that sonarlint-language-server uses stdio channel
                        "-stdio",
                        "-analyzers",
                        -- paths to the analyzers you need, using those for python and java in this example
                        vim.fn.expand("~/prj/utilities/sonarlint/extensions/analzers/sonarpython.jar"),
                        vim.fn.expand("~/prj/utilities/sonarlint/extensions/analzers/sonarcfamily.jar"),
                        vim.fn.expand("~/prj/utilities/sonarlint/extensions/analzers/sonarjava.jar"),
                        vim.fn.expand("~/prj/utilities/sonarlint/extensions/analzers/sonarjs.jar"),
                    },
                    settings = {
                        sonarlint = {
                            rules = {
                                ["typescript:S103"] = { level = "on", parameters = { maximumLineLength = 10 } },
                            },
                        },
                    },
                },
                filetypes = {
                    -- Tested and working
                    "python",
                    "cpp",
                    "java",
                    "javascript",
                    "typescript",
                },
            })
        end,
        event = { "BufReadPre", "BufNewFile" },
    },
}
