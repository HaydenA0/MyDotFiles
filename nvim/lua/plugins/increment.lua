return {
	"monaqa/dial.nvim",
	config = function()
		local augend = require("dial.augend")
		require("dial.config").augends:register_group({
			default = {
				augend.integer.alias.decimal,
				augend.integer.alias.hex,
				augend.date.alias["%Y/%m/%d"],
				augend.constant.alias.bool, -- true <-> false
				augend.constant.new({ elements = { "let", "const" } }),
				augend.constant.new({ elements = { "&&", "||" } }),
				augend.constant.new({ elements = { "==", "!=" } }),
			},
		})

		vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal(), { desc = "Increment" })
		vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal(), { desc = "Decrement" })
		vim.keymap.set("v", "<C-a>", require("dial.map").inc_visual(), { desc = "Increment" })
		vim.keymap.set("v", "<C-x>", require("dial.map").dec_visual(), { desc = "Decrement" })
	end,
}
