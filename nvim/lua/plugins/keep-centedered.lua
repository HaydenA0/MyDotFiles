return {
	"arnamak/stay-centered.nvim",
	config = function()
		vim.keymap.set(
			{ "n", "v" },
			"<leader>cc",
			require("stay-centered").toggle,
			{ desc = "Toggle stay-centered.nvim" }
		)
	end,
}
