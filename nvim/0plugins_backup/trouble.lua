return {
	"folke/trouble.nvim",
	-- Add dependencies if you don't have them elsewhere
	-- dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		-- Your custom options go here
		-- For example, automatically open the list when diagnostics appear
		-- auto_open = true,
		modes = {
			-- A more advanced symbols mode that filters out less useful symbols for certain filetypes
			symbols = {
				mode = "lsp_document_symbols",
				focus = false,
				win = { position = "right" },
				filter = {
					-- remove Package since luals uses it for control flow structures
					["not"] = { ft = "lua", kind = "Package" },
					any = {
						-- all symbol kinds for help / markdown files
						ft = { "help", "markdown" },
						-- default set of symbol kinds
						kind = {
							"Class",
							"Constructor",
							"Enum",
							"Field",
							"Function",
							"Interface",
							"Method",
							"Module",
							"Namespace",
							"Package",
							"Property",
							"Struct",
							"Trait",
						},
					},
				},
			},
		},
	},
	cmd = "Trouble",
	keys = {
		{
			"<leader>xx",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{
			"<leader>xX",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},
		{
			-- This now uses your more advanced 'symbols' mode defined in opts
			"<leader>of",
			"<cmd>Trouble symbols toggle<cr>",
			desc = "Document Symbols (Trouble)",
		},
		{
			"<leader>cr", -- 'c'ode 'r'eferences
			"<cmd>Trouble lsp toggle mode=lsp_references<cr>",
			desc = "LSP References (Trouble)",
		},
		{
			"<leader>cd", -- 'c'ode 'd'efinitions
			"<cmd>Trouble lsp toggle mode=lsp_definitions<cr>",
			desc = "LSP Definitions (Trouble)",
		},
		{
			"<leader>xL",
			"<cmd>Trouble loclist toggle<cr>",
			desc = "Location List (Trouble)",
		},
		{
			"<leader>xQ",
			"<cmd>Trouble qflist toggle<cr>",
			desc = "Quickfix List (Trouble)",
		},
	},
}
