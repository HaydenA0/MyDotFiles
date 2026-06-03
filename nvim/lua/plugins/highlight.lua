return {
	"RRethy/vim-illuminate",
	config = function()
		require("illuminate").configure({

			providers = {
				"lsp",
				"treesitter",
				"regex",
			},

			delay = 1,

			filetypes_denylist = {
				"dirbuf",
				"dirvish",
				"fugitive",
			},

			case_insensitive_regex = false,

			disable_keymaps = false,
		})
		local function set_illuminate_underline()
			-- Target all three possible illuminated word highlight groups
			local groups = { "IlluminatedWordText", "IlluminatedWordRead", "IlluminatedWordWrite" }

			for _, group in ipairs(groups) do
				vim.api.nvim_set_hl(0, group, {
					bg = "none", -- Removes the background color block
					underline = true, -- Enables the underline
					sp = "#ffffff", -- Sets the underline color to white (for GUI/Truecolor)
				})
			end
		end

		-- Apply the styles immediately on startup
		set_illuminate_underline()

		-- Run it again if you switch colorschemes so your changes aren't lost
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			callback = set_illuminate_underline,
		})
	end,
}
