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
            defaults = {
                layout_strategy = "vertical"
            },
			pickers = {
				find_files = {
					hidden = true,
					path_display = { "smart" },
				},
				buffers = {
					path_display = { "smart" },
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
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[Telescope] Find Files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[Telescope] Live Grep" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[Telescope] Buffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[Telescope] Help Tags" })
		-- git ls-files respects .gitignore
		vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "[Telescope] Git Files" })
		-- search input without telescope prompti
		vim.keymap.set("n", "<leader>ps", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end, { desc = "[Telescope] Grep String" })
		vim.keymap.set("n", "<leader>pws", function()
			-- <cword> is the word under the cursor
			local word = vim.fn.expand("<cword>")
			builtin.grep_string({ search = word })
		end, { desc = "[Telescope] Grep Word" })
		vim.keymap.set("n", "<leader>pWs", function()
			-- <cWORD> is the WORD - word with symbols - under the cursor
			local word = vim.fn.expand("<cWORD>")
			builtin.grep_string({ search = word })
		end, { desc = "[Telescope] Grep WORD" })
	end,
}
