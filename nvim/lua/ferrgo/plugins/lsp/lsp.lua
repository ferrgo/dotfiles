return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            -- "hrsh7th/cmp-nvim-lsp",
            -- "hrsh7th/cmp-buffer",
            -- "hrsh7th/cmp-path",
            -- "hrsh7th/cmp-cmdline",
            -- "hrsh7th/nvim-cmp",
            -- "L3MON4D3/LuaSnip",
            -- "saadparwaiz1/cmp_luasnip",
            "j-hui/fidget.nvim",
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
                    require("lspconfig")["yamlls"].setup(cfg)
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
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "ts_ls",
                    "eslint",
                    "bashls",
                    "yamlls",
                },
                handlers = {
                    function(server_name) -- default handler (optional)
                        require("lspconfig")[server_name].setup({
                            -- capabilities = require("cmp_nvim_lsp").default_capabilities(),
                            -- capabilities = require('blink.cmp').get_lsp_capabilities(),
                        })
                    end,
                    ["bashls"] = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.bashls.setup({
                            cmd = { "bash-language-server", "start" },
                            filetypes = { "sh", "bash", "zsh" },
                            root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),
                            settings = {
                                bash = {
                                    filetypes = { "sh", "bash", "zsh" },
                                },
                            },
                        })
                    end, -- lua wat?
                    -- lua wat?
                    ["lua_ls"] = function()
                        -- local cmp_lsp = require("cmp_nvim_lsp")
                        local capabilities = vim.tbl_deep_extend(
                            "force",
                            {},
                            vim.lsp.protocol.make_client_capabilities()
                        -- cmp_lsp.default_capabilities()
                        )
                        -- capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
                        local lspconfig = require("lspconfig")
                        lspconfig.lua_ls.setup({
                            capabilities = capabilities,
                            settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = { "vim", "isdirectory" },
                                    },
                                },
                            },
                        })
                    end,
                    -- lua wat?
                    ["yamlls"] = function()
                        local lspconfig = require("lspconfig")
                        local loft_cloudify_schema =
                        "https://backstage.loft.technology/api/techdocs/static/docs/default/component/cloudify/schemas/contract.json"
                        local kubernetes_schema =
                        "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master-standalone/deployment-apps-v1.json"
                        local sls_schema =
                        "https://raw.githubusercontent.com/lalcebo/json-schema/91c1871843e8346bb87d36a44f1ee06b001279ca/serverless/reference.json"
                        lspconfig.yamlls.setup({
                            settings = {
                                yaml = {
                                    validate = true,
                                    schemaStore = {
                                        url = "https://www.schemastore.org/api/json/catalog.json",
                                        enable = true,
                                    },
                                    schemas = {
                                        -- [url]: [glob]
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
                    end,
                },
            })
            -- local cmp = require("cmp")
            -- local luasnip = require("luasnip")
            local kind_icons = {
                Text = "",
                Method = "󰆧",
                Function = "󰊕",
                Constructor = "",
                Field = "󰇽",
                Variable = "󰂡",
                Class = "󰠱",
                Interface = "",
                Module = "",
                Property = "󰜢",
                Unit = "",
                Value = "󰎠",
                Enum = "",
                Keyword = "󰌋",
                Snippet = "",
                Color = "󰏘",
                File = "󰈙",
                Reference = "",
                Folder = "󰉋",
                EnumMember = "",
                Constant = "󰏿",
                Struct = "",
                Event = "",
                Operator = "󰆕",
                TypeParameter = "󰅲",
            }
            -- -- gray
            -- vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg='NONE', strikethrough=true, fg='#808080' })
            -- -- blue
            -- vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg='NONE', fg='#569CD6' })
            -- vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link='CmpIntemAbbrMatch' })
            -- -- light blue
            -- vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg='NONE', fg='#9CDCFE' })
            -- vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link='CmpItemKindVariable' })
            -- vim.api.nvim_set_hl(0, 'CmpItemKindText', { link='CmpItemKindVariable' })
            -- -- pink
            -- vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg='NONE', fg='#C586C0' })
            -- vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link='CmpItemKindFunction' })
            -- -- front
            -- vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg='NONE', fg='#D4D4D4' })
            -- vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link='CmpItemKindKeyword' })
            -- vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link='CmpItemKindKeyword' })
            -- local cmpConfig = {
            --     snippet = {
            --         expand = function(args)
            --             -- luasnip.lsp_expand(args.body)
            --         end,
            --     },
            --     window = {
            --         completion = cmp.config.window.bordered(),
            --         documentation = cmp.config.window.bordered(),
            --     },
            --     mapping = {
            --         ["<C-p>"] = cmp.mapping.select_prev_item(),
            --         ["<C-n>"] = cmp.mapping.select_next_item(),
            --         ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            --         ['<C-u>'] = cmp.mapping.scroll_docs(4),
            --         ["<C-i>"] = cmp.mapping.complete(),
            --         ['<C-e>'] = cmp.mapping.close(),
            --         ["<C-y>"] = cmp.mapping.confirm({ select = true }),
            --     },
            --     sources = {
            --         { name = "nvim_lsp" },
            --         { name = "luasnip" },
            --         { name = "buffer" },
            --         { name = "path" },
            --         { name = "cmdline" },
            --     },
            --     formatting = {
            --         fields = {"kind", "abbr", "menu"},
            --         format = function(entry, vim_item)
            --             -- Kind icons
            --             vim_item.kind = string.format("%s", kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
            --             -- Source
            --             vim_item.menu = ({
            --                 buffer = "[Buffer]",
            --                 nvim_lsp = "[LSP]",
            --                 luasnip = "[LuaSnip]",
            --                 nvim_lua = "[Lua]",
            --                 latex_symbols = "[LaTeX]",
            --             })[entry.source.name]
            --             return vim_item
            --         end,
            --     },
            -- }
            -- cmp.setup(cmpConfig)
            vim.diagnostic.config({
                update_in_insert = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            })
        end,
    },
}
