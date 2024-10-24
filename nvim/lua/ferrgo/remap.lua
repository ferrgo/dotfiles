vim.g.mapleader=" "

vim.keymap.set("n","<leader>ls", vim.cmd.Ex, {desc="Open current folder in explorer"})

-- Move highlighted line / block of text in visual mode
-- Thanks [ThePrimeagen](https://github.com/ThePrimeagen/init.lua/blob/249f3b14cc517202c80c6babd0f9ec548351ec71/lua/theprimeagen/remap.lua#L5-L6)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- Recenters after movement
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Thanks [ThePrimeagen](https://github.com/ThePrimeagen/init.lua/blob/249f3b14cc517202c80c6babd0f9ec548351ec71/lua/theprimeagen/remap.lua#L21-L22)
-- "_d <- delete to blackhole register
-- P <- paste before cursor
-- [[ ]] <- Strings in lua
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Thanks asbjornHaland and [ThePrimeagen](https://github.com/ThePrimeagen/init.lua/blob/249f3b14cc517202c80c6babd0f9ec548351ec71/lua/theprimeagen/remap.lua#L24-L26)
-- "+y <- yank selection into "+" register (System clipboard) 
-- "+Y <- yank entire line into "+" register (System clipboard)
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Quickfix navigation
vim.keymap.set("n", "[q","<Cmd>cp<CR>",{desc="[Quickfix navigation] Next"})
vim.keymap.set("n", "]q","<Cmd>cn<CR>",{desc="[Quickfix navigation] Previous"})
vim.keymap.set("n", "[Q","<Cmd>cr<CR>",{desc="[Quickfix navigation] First"})
vim.keymap.set("n", "]Q","<Cmd>cla<CR>",{desc="[Quickfix navigation] Last"})
