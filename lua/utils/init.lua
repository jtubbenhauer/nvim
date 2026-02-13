local M = {}

M.get_cwd = function()
	local full_path = vim.api.nvim_buf_get_name(0)
	return full_path:match("(.*[/\\])")
end

M.get_trimmed_cwd = function()
	local cwd = M.get_cwd()
	local is_oil_buffer = string.find(cwd, "oil")

	if is_oil_buffer == nil then
		return
	end

	local path = string.gsub(cwd, "oil:///home/jack", "~")
	local pboard = io.popen("xclip -selection clipboard", "w")
	-- local path = string.gsub(cwd, "oil:///home/jack", "~")
	-- local pboard = io.popen("pbcopy", "w")
	--
	if pboard == nil then
		return
	end

	pboard:write(path)
	pboard:close()
end

M.shorten_path = function(path)
	return path:match(".*/(.*/[^/]+)$") or path
end

M.toggle_diffview_status = function()
	local lib = require("diffview.lib")
	local view = lib.get_current_view()

	if view then
		vim.cmd.DiffviewClose()
	else
		vim.cmd("DiffviewOpen")
	end
end

M.toggle_diffview_branch = function()
	local lib = require("diffview.lib")
	local view = lib.get_current_view()

	if view then
		vim.cmd.DiffviewClose()
	else
		vim.cmd("DiffviewOpen origin/HEAD")
		-- require("fzf-lua").git_branches({
		-- 	actions = {
		-- 		["enter"] = function(selected)
		-- 			vim.cmd("DiffviewOpen " .. selected[1])
		-- 		end,
		-- 	},
		-- })
	end
end

M.fzf_dirs = function(opts)
	local fzf_lua = require("fzf-lua")
	opts = opts or {}
	opts.prompt = "Directories> "

	opts.fn_transform = function(x)
		local utils = require("fzf-lua.utils")
		return utils.ansi_codes.magenta(x)
	end

	opts.actions = {
		["enter"] = function(selected)
			local cwd = vim.fn.getcwd()
			vim.cmd("Oil " .. cwd .. "/" .. selected[1])
		end,
	}
	fzf_lua.fzf_exec("fd --type d", opts)
end

M.fzf_git_changes = function()
	require("fzf-lua").git_files({
		cmd = "git diff --name-only origin/HEAD",
	})
end

M.grep_directory = function()
	local oil = require("oil")
	local dir = oil.get_current_dir()
	if dir == nil then
		return
	end
	require("fzf-lua").live_grep({
		cwd = dir,
	})
end

M.change_git_signs_base = function()
	require("fzf-lua").git_branches({
		actions = {
			["enter"] = function(selected)
				-- fzf-lua returns the raw string in selected[1]
				-- We need to strip the prefix (+, *, space) and take the first word
				local branch = selected[1]:match("[%*%+]?%s*([^%s]+)")

				if branch then
					require("gitsigns").change_base(branch)
					print("Gitsigns base changed to: " .. branch)
				end
			end,
		},
	})
end

M.change_git_signs_base_v1 = function()
	require("fzf-lua").git_branches({
		actions = {
			["enter"] = function(selected)
				local str = selected[1]
				str = str:gsub("^%s*(.-)%s*$", "%1") -- remove leading and trailing whitespace
				require("gitsigns").change_base(str)
			end,
		},
	})
end

M.open_split_to_cwd = function()
	local splits = vim.api.nvim_list_wins()
	if #splits == 1 then
		vim.cmd("vsplit")
		vim.cmd()
	end

	if #splits > 1 then
		vim.cmd("wincmd l")
	end
end

-- local chat = require("CopilotChat")

-- M.copilot_chat = function()
-- 	vim.ui.input({
-- 		prompt = "Chat prompt: ",
-- 	}, function(input)
-- 		if input then
-- 			chat.ask(input)
-- 		end
-- 	end)
-- end
--
-- M.copilot_chat_toggle = function()
-- 	chat.toggle()
-- end

M.format_buffer = function()
	require("conform").format()
end

M.copy_buffer_dir = function()
	-- %:p:h  => absolute path of the file's directory
	local dir = vim.fn.expand("%:p:h")
	vim.fn.setreg("+", dir) -- system clipboard
	vim.fn.setreg('"', dir) -- unnamed register (handy for :put)
	print("📋 Copied: " .. dir)
end

M.copy_buffer_path = function()
	-- %:p  => absolute path of the file
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path) -- system clipboard
	vim.fn.setreg('"', path) -- unnamed register (handy for :put)
	print("📋 Copied: " .. path)
end

return M
