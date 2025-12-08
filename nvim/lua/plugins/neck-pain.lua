return {
	"shortcuts/no-neck-pain.nvim",
	config = function()
		local map = vim.keymap.set

		map("n", "<A-Space>", "<cmd>NoNeckPain<CR>")
	end,
}
