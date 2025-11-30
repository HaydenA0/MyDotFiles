-- return {
-- 	"uZer/pywal16.nvim",
-- 	-- for local dev replace with:
-- 	-- dir = '~/your/path/pywal16.nvim',
-- 	config = function()
-- 		vim.cmd.colorscheme("pywal16")
-- 	end,
-- }
-- File: lua/themes/muted_dark.lua
return {
	{
		"xiyaowong/transparent.nvim",
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = false, -- load immediately
		config = function()
			local has_treesitter, _ = pcall(require, "nvim-treesitter")

			require("kanagawa").setup({
				background = {
					dark = "dragon",
					light = "lotus",
				},
				transparent = true, -- enable transparency
				keywordStyle = { bold = true, italic = false },
			})

			vim.cmd("colorscheme kanagawa")

			-- Ensure transparency by clearing background highlights
			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
			vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
			vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
			vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })
		end,
	},
}
