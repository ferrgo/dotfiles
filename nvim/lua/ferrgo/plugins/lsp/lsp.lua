return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "j-hui/fidget.nvim",
            {
                "folke/lazydev.nvim",
                ft = "lua",
                opts = {
                    library = {
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
            {
                "someone-stole-my-name/yaml-companion.nvim",
                requires = {
                    { "neovim/nvim-lspconfig" },
                    { "nvim-lua/plenary.nvim" },
                    { "nvim-telescope/telescope.nvim" },
                },
                config = function()
                    require("telescope").load_extension("yaml_schema")
                    local cfg = require("yaml-companion").setup()
                    vim.lsp.config("yamlls", cfg)
                end,
            },
        },
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })

            vim.lsp.config("eslint", {
                on_attach = function() end,
            })

            vim.lsp.config("bashls", {
                cmd = { "bash-language-server", "start" },
                filetypes = { "sh", "bash", "zsh" },
                root_markers = { ".git" },
                settings = {
                    bash = {
                        filetypes = { "sh", "bash", "zsh" },
                    },
                },
            })

            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim", "isdirectory" },
                        },
                    },
                },
            })

            local loft_cloudify_schema =
                "https://backstage.loft.technology/api/techdocs/static/docs/default/component/cloudify/schemas/contract.json"
            local kubernetes_schema =
                "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master-standalone/deployment-apps-v1.json"
            local sls_schema =
                "https://raw.githubusercontent.com/lalcebo/json-schema/91c1871843e8346bb87d36a44f1ee06b001279ca/serverless/reference.json"

            vim.lsp.config("yamlls", {
                settings = {
                    yaml = {
                        validate = true,
                        schemaStore = {
                            url = "https://www.schemastore.org/api/json/catalog.json",
                            enable = true,
                        },
                        schemas = {
                            [kubernetes_schema] = "k8s-apps/deployments/**/**/*.yaml",
                            [loft_cloudify_schema] = ".cloudify/{production,development}/*/*.yaml",
                            [sls_schema] = "serverless.yml|serverless.yaml",
                        },
                        customTags = {
                            "!Ref scalar",
                        },
                    },
                },
            })

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "ts_ls",
                    "eslint",
                    "bashls",
                    "yamlls",
                },
            })

            vim.diagnostic.config({
                update_in_insert = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = true, -- "always",
                    header = "",
                    prefix = "",
                },
            })
        end,
    },
}
