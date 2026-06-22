return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_format" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			cu = { "clang-format" },
			rust = { "rustfmt" },
			go = { "gofmt" },
		},
		formatters = {
			clang_format = {

				prepend_args = { "-assume-filename", "file.cpp" },
			},
		},
		-- format_on_save = {
		-- 	timeout_ms = 500,
		-- 	lsp_format = "fallback",
		-- },
	},
}
