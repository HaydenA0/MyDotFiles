return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			rust = { "rustfmt" },
			go = { "gofmt" },
		},
	},
	config = function(_, opts)
		local conform = require("conform")
		conform.setup(opts)

		-- Format on save
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function()
				conform.format({ async = false })
			end,
		})
	end,
}
