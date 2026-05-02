return {
	"supermaven-inc/supermaven-nvim",
	event = "InsertEnter",
	config = function()
		require("supermaven-nvim").setup({
			keymaps = { accept_suggestion = "<A-Tab>", clear_suggestion = "<C-]>", accept_word = "<C-j>" },
			condition = function()
				local ok, blink = pcall(require, "blink.cmp")
				return ok and blink.is_visible()
			end,
		})
	end,
}

-- add this to the file where you setup your other plugins:
-- return {
-- 	"monkoose/neocodeium",
-- 	config = function()
-- 		local neocodeium = require("neocodeium")
-- 		neocodeium.setup()
-- 		vim.keymap.set("i", "<A-Tab>", neocodeium.accept)
-- 	end,
-- }
