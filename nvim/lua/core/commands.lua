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

local function clean_buffers()
	local current = vim.api.nvim_get_current_buf()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted and buf ~= current then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
	print("Cleaned all other buffers.")
end

_G.cleanBuffers = clean_buffers
vim.api.nvim_create_user_command("CleanBuffers", clean_buffers, {
	desc = "Close all buffers except the current one",
})

-- vim.api.nvim_create_user_command("RunFile", function(args)
-- 	local file_path = vim.api.nvim_buf_get_name(0)
-- 	if file_path == "" then
-- 		vim.notify("Error: Buffer is not associated with a file. Please save it first.", vim.log.levels.ERROR)
-- 		return
-- 	end
--
-- 	local command_to_run
-- 	if file_path:match("%.c$") then
-- 		command_to_run = "make run"
-- 	elseif file_path:match("%.py$") then
-- 		command_to_run = "python3 " .. vim.fn.shellescape(file_path)
-- 	else
-- 		vim.notify("Error: No run command configured for this file type.", vim.log.levels.ERROR)
-- 		return
-- 	end
--
-- 	local output_to_buffer = (args.fargs[1] == "editable=true")
--
-- 	if output_to_buffer then
-- 		vim.notify("Running: " .. command_to_run .. " (capturing output)", vim.log.levels.INFO)
--
-- 		local output_lines = vim.fn.systemlist(command_to_run .. " 2>&1")
--
-- 		local buf = vim.api.nvim_create_buf(false, true)
--
-- 		vim.cmd("botright split")
--
-- 		vim.api.nvim_win_set_buf(0, buf)
--
-- 		vim.api.nvim_buf_set_option(buf, "filetype", "text")
-- 		vim.api.nvim_buf_set_option(buf, "modifiable", true)
--
-- 		vim.api.nvim_buf_set_lines(buf, 0, -1, false, output_lines)
--
-- 		vim.notify("Output captured in a new editable buffer.", vim.log.levels.INFO)
-- 	else
-- 		vim.notify("Running: !" .. command_to_run, vim.log.levels.INFO)
-- 		vim.cmd("!" .. command_to_run)
-- 	end
-- end, {
-- 	nargs = "?",
-- 	desc = "Run file. Pass 'editable=true' to pipe output to a new buffer.",
-- })
