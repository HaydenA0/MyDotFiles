return {

	"gbprod/substitute.nvim",
	config = function()
		local substitute = require("substitute")

		-- 1. Setup the plugin
		substitute.setup({
			-- You can leave this empty for defaults,
			-- but here is the specific section for exchange behavior
			exchange = {
				motion = false,
				use_esc_to_cancel = true,
				preserve_cursor_position = false,
			},
		})

		-- 2. Create the Keymap (THIS IS THE CRITICAL PART)
		-- Map 'X' in Visual mode to the exchange visual function
		vim.keymap.set(
			"x",
			"X",
			require("substitute.exchange").visual,
			{ noremap = true, desc = "Exchange Visual Selection" }
		)

		-- Optional: Useful Normal mode maps if you want them later
		vim.keymap.set(
			"n",
			"sx",
			require("substitute.exchange").operator,
			{ noremap = true, desc = "Exchange Operator" }
		)
		vim.keymap.set("n", "sxc", require("substitute.exchange").cancel, { noremap = true, desc = "Cancel Exchange" })
	end,
}
