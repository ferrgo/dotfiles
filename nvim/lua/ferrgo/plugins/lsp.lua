return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/nvim-cmp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			{ "j-hui/fidget.nvim", opts = {} },
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
					"tsserver",
					"eslint",
					"bashls",
					"yamlls",
				},
				handlers = {
					function(server_name) -- default handler (optional)
						require("lspconfig")[server_name].setup({
							capabilities = require("cmp_nvim_lsp").default_capabilities(),
						})
					end,
					-- lua wat?
					["lua_ls"] = function()
						local cmp_lsp = require("cmp_nvim_lsp")
						local capabilities = vim.tbl_deep_extend(
							"force",
							{},
							vim.lsp.protocol.make_client_capabilities(),
							cmp_lsp.default_capabilities()
						)
						local lspconfig = require("lspconfig")
						lspconfig.lua_ls.setup({
							capabilities = capabilities,
							settings = {
								Lua = {
									diagnostics = {
										globals = { "vim" },
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
									},
								},
							},
						})
					end,
				},
			})
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = {
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-n>"] = cmp.mapping.select_next_item(),
					--['<C-d>'] = cmp.mapping.scroll_docs(-4),
					--['<C-f>'] = cmp.mapping.scroll_docs(4),
					["<C-i>"] = cmp.mapping.complete(),
					--['<C-e>'] = cmp.mapping.close(),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "cmdline" },
				},
			})
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
	{
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
	},
}

--[[
return {
sssss   "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "tsserver",
                "bashls",
                "yamlls",
            },
            handlers = {
                function(server_name) -- default handler (optional)

                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
]]
--
