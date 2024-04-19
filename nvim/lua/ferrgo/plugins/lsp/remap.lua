-- Defaults from [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/blob/24662f92c18edd397ef12d635b11dbdedef2d094/README.md)
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "[LSP] Open floating diagnostic" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "[LSP] Go to previous" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "[LSP] Go to next" })
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "[LSP] Open diagnostic on quickfix list" })

local opts = { noremap = true, silent = true, desc = "[LSP] [LSP] Quickfix" }

-- Quickfix from [this so ans](https://stackoverflow.com/a/74303272)
local function quickfix()
	vim.lsp.buf.code_action({
		filter = function(a)
			return a.isPreferred
		end,
		apply = true,
	})
end

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		-- local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "[LSP] Go to declaration" })
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "[LSP] Go to definition" })
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "[LSP] LSP Hover info" })
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = ev.buf, desc = "[LSP] List implementations" })
		vim.keymap.set(
			"n",
			"<C-k>",
			vim.lsp.buf.signature_help,
			{ buffer = ev.buf, desc = "[LSP] Displays signature information" }
		)
		vim.keymap.set(
			"n",
			"<space>wa",
			vim.lsp.buf.add_workspace_folder,
			{ buffer = ev.buf, desc = "[LSP] Add a folter to workspace" }
		)
		vim.keymap.set(
			"n",
			"<space>wr",
			vim.lsp.buf.remove_workspace_folder,
			{ buffer = ev.buf, desc = "[LSP] Remove a folder from workspace" }
		)
		vim.keymap.set("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, { buffer = ev.buf, desc = "[LSP] List workspace folders" })
		vim.keymap.set(
			"n",
			"<space>D",
			vim.lsp.buf.type_definition,
			{ buffer = ev.buf, desc = "[LSP] Jump to type defintion" }
		)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "[LSP] Rename" })
		vim.keymap.set(
			{ "n", "v" },
			"<space>ca",
			vim.lsp.buf.code_action,
			{ buffer = ev.buf, desc = "[LSP] Selects a code action" }
		)
		vim.keymap.set("n", "gr", "<CMD>Telescope lsp_references<CR>", { buffer = ev.buf, desc = "[LSP] List references to the symbol" })
		--[[ Using keybindings on conform.nvim and not default lsp.format
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  ]]
		--
		vim.keymap.set("n", "<leader>fix", quickfix, opts)
	end,
})

return {}
