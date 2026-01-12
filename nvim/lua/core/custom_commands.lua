local function clear_comments()
	local commentstring = vim.bo.commentstring
	if not commentstring or commentstring == "" then
		print("No comment string defined for this filetype")
		return
	end

	local comment_pattern = commentstring:gsub("%%s", ""):gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")

	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	for i, line in ipairs(lines) do
		lines[i] = line:gsub("%s*" .. comment_pattern .. ".*", "")
	end

	vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
	print("Comments cleared!")
end

vim.api.nvim_create_user_command("ClearComments", clear_comments, {
	desc = "Remove all comments from the current buffer",
})

local function zoxide_to_oil()
	require("fzf-lua").fzf_exec("zoxide query -l", {
		actions = {
			["default"] = function(selected)
				local path = selected[1]
				if path then
					vim.fn.chdir(path)
					require("oil").open(path)
				end
			end,
		},
		winopts = {
			title = " Teleport to Directory (Zoxide) ",
			height = 0.40,
			width = 0.60,
		},
	})
end

vim.keymap.set("n", "<leader>j", zoxide_to_oil, { desc = "Zoxide Teleport to Oil" })
