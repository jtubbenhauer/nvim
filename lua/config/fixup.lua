local set = vim.keymap.set

local function get_fixup_path()
	return vim.fn.getcwd() .. "/.opencode/fixups.md"
end

local function ensure_fixup_file()
	local dir = vim.fn.getcwd() .. "/.opencode"
	vim.fn.mkdir(dir, "p")

	local path = get_fixup_path()
	local f = io.open(path, "r")
	if f then
		f:close()
		return
	end

	f = io.open(path, "w")
	if f then
		f:write("# Review Notes\n\n")
		f:close()
	end
end

local function append_fixup(file, line_ref, note)
	ensure_fixup_file()
	local path = get_fixup_path()

	local f = io.open(path, "a")
	if not f then
		vim.notify("Could not open fixups file", vim.log.levels.ERROR)
		return
	end

	f:write(string.format("- `%s:%s` - %s\n", file, line_ref, note))
	f:close()
	vim.notify(string.format("Note added: %s:%s", file, line_ref), vim.log.levels.INFO)
end

local function open_fixup_popup(file, line_ref)
	local buf = vim.api.nvim_create_buf(false, true)

	local width = 60
	local height = 3
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "cursor",
		row = 1,
		col = 0,
		width = width,
		height = height,
		style = "minimal",
		border = "rounded",
		title = string.format(" %s:%s ", file, line_ref),
		title_pos = "center",
	})

	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].filetype = "markdown"
	vim.cmd("startinsert")

	local function save_and_close()
		local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
		local note = vim.fn.trim(table.concat(lines, " "))
		if note ~= "" then
			append_fixup(file, line_ref, note)
		end
		vim.api.nvim_win_close(win, true)
	end

	local function cancel()
		vim.api.nvim_win_close(win, true)
	end

	local bopts = { buffer = buf, noremap = true, silent = true }
	vim.keymap.set("n", "<CR>", save_and_close, bopts)
	vim.keymap.set("n", "q", cancel, bopts)
	vim.keymap.set("n", "<Esc>", cancel, bopts)
end

-- Normal mode: note on current line
set("n", "<leader>fn", function()
	local file = vim.fn.expand("%:.")
	local line = vim.fn.line(".")
	open_fixup_popup(file, tostring(line))
end, { desc = "Add review note" })

-- Visual mode: note on selected range
set("v", "<leader>fn", function()
	local start_line = vim.fn.line("v")
	local end_line = vim.fn.line(".")
	if start_line > end_line then
		start_line, end_line = end_line, start_line
	end

	local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
	vim.api.nvim_feedkeys(esc, "nx", false)

	local file = vim.fn.expand("%:.")
	local line_ref = start_line == end_line and tostring(start_line)
		or string.format("%d-%d", start_line, end_line)
	open_fixup_popup(file, line_ref)
end, { desc = "Add review note (range)" })

-- List fixup notes
set("n", "<leader>fl", function()
	local path = get_fixup_path()
	local f = io.open(path, "r")
	if not f then
		vim.notify("No fixups file found", vim.log.levels.INFO)
		return
	end
	f:close()
	vim.cmd("edit " .. path)
end, { desc = "List review notes" })

-- Clear fixup notes
set("n", "<leader>fc", function()
	local path = get_fixup_path()
	local f = io.open(path, "w")
	if not f then
		vim.notify("Could not open fixups file", vim.log.levels.ERROR)
		return
	end
	f:write("# Review Notes\n\n")
	f:close()
	vim.notify("Review notes cleared", vim.log.levels.INFO)
end, { desc = "Clear review notes" })
