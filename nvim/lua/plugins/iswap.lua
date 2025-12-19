return {
	"mizlan/iswap.nvim",
	event = "VeryLazy",
	config = function()
		vim.keymap.set({ "n" }, "<leader>c", "<cmd>ISwapNodeWith<CR>", { desc = "Enter command mode" })
	end,
}
