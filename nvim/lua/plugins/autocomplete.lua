return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "1.*",
	event = "InsertEnter",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		snippets = { preset = "luasnip" },
		keymap = {
			preset = "super-tab",
			["<C-j>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
		},

		appearance = {
			nerd_font_variant = "mono",
		},

		completion = {
			ghost_text = { enabled = true },

			documentation = { auto_show = false },
			menu = { border = "rounded" },
		},

		sources = {
			default = { "snippets", "lsp", "path", "buffer" },
		},

		fuzzy = { implementation = "prefer_rust_with_warning" },
		signature = { enabled = true },
	},
	opts_extend = { "sources.default" },
}
