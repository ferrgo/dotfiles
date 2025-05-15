-- vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

-- vim.opt.swapfile = false
-- vim.opt.backup = false

-- TODO: Find better place for that
-- TODO: Test on Linux
-- TODO: Test on windows
--- Check if a file or directory exists in this path
ExistsFile = function(file)
   local ok, err, code = os.rename(file, file)
   if not ok then
      if code == 13 then
         -- Permission denied, but it exists
         return true
      end
   end
   return ok, err
end

--- Check if a directory exists in this path
IsDir = function(path)
   -- "/" works on both Unix and Windows
   return ExistsFile(path.."/")
end

-- set undodir as a variable
local undodir = os.getenv("HOME") .. "/.vim/undodir"
-- TODO: define permissions
if not IsDir(undodir) then
   os.execute("mkdir -m 0700 -p " .. undodir)
end

-- Prepend mise shims to PATH
vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH

vim.opt.undodir = undodir
vim.opt.undofile = true
vim.opt.undolevels = 10000

-- vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes:2"
-- vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80,120"
vim.opt.conceallevel = 2

vim.opt.pumheight = 8

-- Options for NetRW (file explorer)
-- (default) noma nomod nonu nowrap ro nobl
-- noma - no modifiable
-- nomod - no modified
-- nu - set number
-- rnu - relative number
-- nobl - no buffer list
-- nowrap - no wrap
-- ro - read only
vim.g.netrw_bufsettings = 'noma nomod nu ro rnu nowrap nobl'
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 25
-- Generic options for folding see [treesitter](./plugins/treesitter.lua) for more specific foldin
-- TODO: Test this
-- vim.opt.foldtext = ""
-- vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 3

-- make zsh files recognized as sh for bash-ls & treesitter
vim.filetype.add {
	extension = {
		zsh = "sh",
		sh = "sh", -- force sh-files with zsh-shebang to still get sh as filetype
	},
	filename = {
		[".zshrc"] = "sh",
		[".zshenv"] = "sh",
	},
}
