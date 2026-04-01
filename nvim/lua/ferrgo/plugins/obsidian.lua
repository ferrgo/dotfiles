local vaults = "" .. vim.fn.expand "~" .. "/src/notes/"
local defaultVault = vaults .. "hfg/"
local inboxDir = "000-inbox/"
local resourcesDir = '300-resources/'
-- return {
--     "epwalsh/obsidian.nvim",
--     version = "*", -- recommended, use latest release instead of latest commit
--     lazy = true,
--     -- ft = "markdown",
--     -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
--     event = {
--         -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
--         -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
--         "BufReadPre " .. defaultVault .. "/**.md",
--         "BufNewFile " .. defaultVault .. "/**.md",
--     },
--     dependencies = {
--         -- Required.
--         "nvim-lua/plenary.nvim",
--     },
--     opts = {
--         workspaces = {
--             {
--                 name = "default",
--                 path = defaultVault,
--             },
--         },
--         daily_notes = {
--             folder = inboxDir,
--             -- folder = "/03-resources/daily-notes/",
--         }
--     },
-- }
return {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- use latest release, remove to use latest commit
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
        legacy_commands = false, -- this will be removed in the next major release
        new_notes_location = "notes_subdir",
        notes_subdir = "001-zettelkasten",
        daily_notes = {
            folder = resourcesDir .. "daily-notes",
            date_format = "%Y-%m-%d",
        },
        ---@param title string|nil
        ---@return string
        note_id_func = function(title)
            local timestamp = os.date("%Y%m%d%H%M")
            if title then
                local slug = title:lower():gsub(" ", "-"):gsub("[^a-z0-9%-]", "")
                return timestamp .. "-" .. slug
            end
            return timestamp
        end,
        templates = {
            folder = resourcesDir .. "templates/",
        },
        workspaces = {
            {
                name = "personal",
                path = defaultVault,
            },
        },
    },
}
