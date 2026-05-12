return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets", "L3MON4D3/LuaSnip" },
	version = "1.*",
	event = "InsertEnter",
	opts = {
		snippets = { preset = "luasnip" },
		keymap = {
			preset = "super-tab",
			["<C-j>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
		},

		completion = {
			documentation = { auto_show = false },
			menu = {
				-- 'single' gives you a thin box. Use 'none' for no border at all.
				border = "single",

				draw = {
					-- We remove the gap and extra columns to keep it as a clean list
					columns = { { "label", "kind", gap = 1 } },
					components = {
						label = {
							width = { fill = true, max = 60 },
						},
						kind = {
							-- This keeps the "Function/Variable" text but makes it subtle
							highlight = "Comment",
						},
					},
				},
			},
		},

		-- Rest of your config...
		appearance = { nerd_font_variant = "mono" },
		sources = { default = { "snippets", "lsp", "path", "buffer" } },
		fuzzy = { implementation = "prefer_rust_with_warning" },
		signature = { enabled = true },
	},
}
