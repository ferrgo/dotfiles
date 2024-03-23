return {
    { import= "ferrgo.plugins.lsp" },
	{
		"freddiehaddad/feline.nvim",
		opts = {},
	},
	"github/copilot.vim",	
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
