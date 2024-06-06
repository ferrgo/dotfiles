return {
	{ import = "ferrgo.plugins.lsp" },
	"github/copilot.vim",
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
