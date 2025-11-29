return {
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*", -- optional but keeps it stable
		build = "make install_jsregexp", -- enables advanced regex features
		config = function()
			local ls = require("luasnip")
			local s = ls.snippet
			local t = ls.text_node
			local i = ls.insert_node
			local extras = require("luasnip.extras")
			local replace = extras.rep

			ls.add_snippets("python", {
				s("hello", {
					t('print("Hello'),
					i(1),
					t(' world")'),
					i(1),
				}),
			})
		end,
	},
}
