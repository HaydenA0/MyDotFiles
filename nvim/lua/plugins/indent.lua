return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	config = function()
		local ibl = require("ibl")
		local hooks = require("ibl.hooks")

		-- This hook ensures the highlight group actually draws a horizontal line (underline)
		-- It runs every time your colorscheme loads so it doesn't get overwritten.
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "IblScope", {
				fg = "none", -- Hides any stray vertical text colors
				underline = true, -- Forces the horizontal line to appear
				sp = "#908caa", -- The color of the horizontal line (Rose Pine 'muted' color)
			})
		end)

		ibl.setup({
			indent = {
				-- We MUST use a space here. If it's an empty string "", there is nothing to underline!
				char = " ",
			},
			scope = {
				enabled = true,
				char = " ", -- Hides the vertical line for the active scope
				show_start = false, -- Draws the horizontal line above the scope
				show_end = true, -- Draws the horizontal line below the scope
			},
		})
	end,
}
