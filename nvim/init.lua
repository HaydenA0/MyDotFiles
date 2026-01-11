vim.g.mapleader = " "
require("core.keybindings")
require("core.custom_commands")
require("core.options")
require("config.lazy")
vim.api.nvim_set_hl(0, "Whitespace", { fg = "#555555", bold = false })
