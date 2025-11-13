local keymap = vim.keymap.set

-- General Keymaps
keymap("v", "<C-c>", '"+y', { noremap = true, silent = true, desc = "Copy to system clipboard" })
keymap("i", "<C-p>", '<C-r>"', { noremap = true, silent = true, desc = "Paste from register" })
keymap("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true, desc = "Exit terminal mode" })
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { silent = true, desc = "Clear search highlight" })
keymap("n", "0", "0", { noremap = true })
keymap("n", "00", "$", { noremap = true, desc = "Go to end of line" })
keymap({ "v", "o" }, "0", "0", { noremap = true })
keymap({ "v", "o" }, "00", "$", { noremap = true, desc = "Go to end of line" })

-- Window Management
keymap("n", "<A-Tab>", "<C-w>w", { noremap = true, desc = "Switch to next window" })
keymap("n", "<A-j>", "<C-w>j", { noremap = true, desc = "Move to window below" })
keymap("n", "<A-k>", "<C-w>k", { noremap = true, desc = "Move to window above" })
keymap("n", "<A-l>", "<C-w>l", { noremap = true, desc = "Move to window right" })
keymap("n", "<A-h>", "<C-w>h", { noremap = true, desc = "Move to window left" })

-- Move window to edge
keymap("n", "<A-H>", "<C-w>H", { noremap = true, desc = "Move window to far left" })
keymap("n", "<A-J>", "<C-w>J", { noremap = true, desc = "Move window to bottom" })
keymap("n", "<A-K>", "<C-w>K", { noremap = true, desc = "Move window to top" })
keymap("n", "<A-L>", "<C-w>L", { noremap = true, desc = "Move window to far right" })

-- Resize window
keymap("n", "<A-Up>", ":resize +2<CR>", { noremap = true, desc = "Increase window height" })
keymap("n", "<A-Down>", ":resize -2<CR>", { noremap = true, desc = "Decrease window height" })
keymap("n", "<A-Left>", ":vertical resize -2<CR>", { noremap = true, desc = "Decrease window width" })
keymap("n", "<A-Right>", ":vertical resize +2<CR>", { noremap = true, desc = "Increase window width" })

-- Tab Management
-- keymap("n", "<A-f>", ":tabnew<CR>:b#<CR>:bwipeout #<CR>", { noremap = true, desc = "Move buffer to new tab" })
-- keymap("n", "<A-1>", "1gt", { noremap = true, desc = "Go to tab 1" })
-- keymap("n", "<A-2>", "2gt", { noremap = true, desc = "Go to tab 2" })
-- keymap("n", "<A-3>", "3gt", { noremap = true, desc = "Go to tab 3" })
-- keymap("n", "<A-4>", "4gt", { noremap = true, desc = "Go to tab 4" })

-- Plugin Keymaps (Grouped by plugin)
-- Telescope / Neoclip
keymap("n", "<leader>r", function()
	require("telescope").extensions.neoclip.default()
end, { desc = "Open Neoclip registers" })

-- Floaterm
keymap("n", "<C-/>", ":FloatermToggle<CR>", { desc = "Toggle floating terminal" })

-- Custom Commands Keymaps
-- keymap("n", "<C-S-Enter>", ":RunFile<CR>", { noremap = true, silent = true, desc = "Run C code " })
