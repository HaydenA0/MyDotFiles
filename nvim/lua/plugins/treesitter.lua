-- I though tis is now in the native nvim +0.12
-- really I am confused

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main", -- Must use main branch for Neovim 0.12+
	build = ":TSUpdate",
	lazy = false,
	config = function()
		local ts = require("nvim-treesitter")

		-- Call setup with an empty table or basic settings (no 'highlight' or 'indent' block)
		ts.setup({})

		-- Explicitly install the languages you work with
		ts.install({
			"lua",
			"python",
			"rust",
			"go",
			"cpp",
			"bash",
			"markdown",
		})
	end,
}
