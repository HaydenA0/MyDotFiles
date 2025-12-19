local colors = {
	bg = "#222222",
	fg = "#dddddd",
	grey = "#888888",
	-- key_word = "#eeee33",
	key_word = "#ffa276",
	conditional_word = "#ffdd76",
	secondary_word = "#8fb6d8",

	-- secondary_word = "#33ee33",
}

local highlights = {

	Normal = { fg = colors.fg, bg = colors.bg },
	LineNr = { fg = colors.grey },
	CursorLine = { bg = "#2a2a2a" },

	["@variable"] = { fg = colors.fg },
	["@variable.builtin"] = { fg = colors.fg },
	["@parameter"] = { fg = colors.fg },
	["@property"] = { fg = colors.fg },
	["@punctuation"] = { fg = colors.fg },
	Delimiter = { fg = colors.fg },
	Operator = { fg = colors.fg },
	Number = { fg = colors.fg },
	Float = { fg = colors.fg },
	Type = { fg = colors.fg },

	String = { fg = colors.secondary_word },
	Character = { fg = colors.secondary_word },
	Special = { fg = colors.secondary_word },

	["@function"] = { fg = colors.fg, bold = true },
	["@constructor"] = { fg = colors.key_word },
	["@constant.builtin"] = { fg = colors.key_word },
	Boolean = { fg = colors.key_word },

	["@keyword.conditional"] = { fg = colors.key_word, bold = true },
	["@keyword.repeat"] = { fg = colors.key_word, bold = true },
	["@keyword.function"] = { fg = colors.key_word, bold = true },
	["@keyword.exception"] = { fg = colors.key_word, bold = true },

	["@keyword"] = { fg = colors.key_word, bold = true },
	Statement = { fg = colors.key_word, bold = true },
	Conditional = { fg = colors.key_word, bold = true },
	Repeat = { fg = colors.key_word, bold = true },

	Comment = { fg = colors.grey },

	Visual = { bg = colors.secondary_word, fg = colors.bg },

	Search = { fg = colors.bg, bg = colors.key_word },
	IncSearch = { fg = colors.bg, bg = colors.key_word },

	DiagnosticError = { fg = colors.key_word, bold = true },
	DiagnosticWarn = { fg = colors.key_word },
	DiagnosticInfo = { fg = colors.secondary_word },
	DiagnosticHint = { fg = colors.secondary_word },
	DiagnosticUnderlineError = { undercurl = true, sp = colors.key_word },

	Pmenu = { bg = "#1a1a1a", fg = colors.fg },
	PmenuSel = { bg = colors.key_word, fg = colors.bg },
	StatusLine = { fg = colors.bg, bg = colors.bg },
	StatusLineNC = { fg = colors.bg, bg = colors.bg },
}

for group, opts in pairs(highlights) do
	vim.api.nvim_set_hl(0, group, opts)
end
