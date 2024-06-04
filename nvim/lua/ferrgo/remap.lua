vim.g.mapleader=" "

vim.keymap.set("n","<leader>ls", vim.cmd.Ex, {desc="Open current folder in explorer"})

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
