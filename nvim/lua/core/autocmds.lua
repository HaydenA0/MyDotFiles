local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Create a group to organize autocommands
local MyAutoCmds = augroup("MyAutoCmds", { clear = true })

-- Change CWD to the current file's directory
autocmd("BufEnter", {
	group = MyAutoCmds,
	callback = function()
		vim.cmd("silent! lcd %:p:h")
	end,
})

-- Create a dedicated augroup for our custom highlight overrides.
local highlight_group = vim.api.nvim_create_augroup("MyFlashHighlightFix", { clear = true })

-- Create an autocommand that runs ONLY when the pywal16 colorscheme is loaded.
vim.api.nvim_create_autocmd("ColorScheme", {
	group = highlight_group,
	pattern = "pywal16",
	callback = function()
		-- Dynamically get the current pywal colors
		local colors = require("pywal16.core").get_colors()

		-- 1. FIX THE CURSOR INSIDE FLASH
		-- This is the block over the 't' in your image.
		-- We are targeting `FlashCursor`, not the normal `Cursor`.
		vim.api.nvim_set_hl(0, "FlashCursor", {
			fg = colors.background, -- Make text under the Flash cursor dark
			bg = colors.color4, -- Make the Flash cursor block bright blue
		})

		-- 2. FIX THE SEARCH MATCH HIGHLIGHT
		-- This is the purple background on 'out' in your image.
		vim.api.nvim_set_hl(0, "FlashMatch", {
			fg = colors.background, -- Make the text on the match dark
			bg = colors.color5, -- Make the match background bright magenta
			bold = true,
		})

		-- 3. FIX THE JUMP LABELS (Good practice for the next step)
		-- This will be the single character you press to jump.
		vim.api.nvim_set_hl(0, "FlashLabel", {
			fg = colors.background, -- Make the label text dark
			bg = colors.color3, -- Make the label background bright yellow
			bold = true,
			nocombine = true,
		})
	end,
})
