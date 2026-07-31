vim.pack.add({ "https://github.com/nvim-lua/plenary.nvim" })
vim.pack.add({ "https://github.com/MeanderingProgrammer/render-markdown.nvim" })
vim.pack.add({
	"file://" .. os.getenv("HOME") .. "/dev/opencode.nvim",
	-- "https://github.com/jtubbenhauer/opencode.nvim",
})

require("render-markdown").setup({
	anti_conceal = { enabled = false },
	file_types = { "markdown", "opencode_output" },
})

local function opencode_note()
	local original_win = vim.api.nvim_get_current_win()
	local path = vim.fn.expand("%:.")
	local mode = vim.fn.mode()
	local location

	if mode:match("[vV\22]") then
		local start_line = vim.fn.getpos("v")[2]
		local end_line = vim.fn.getpos(".")[2]
		if start_line > end_line then
			start_line, end_line = end_line, start_line
		end
		vim.cmd("normal! \27")
		if start_line ~= end_line then
			location = path .. ":" .. start_line .. "-" .. end_line
		else
			location = path .. ":" .. start_line
		end
	else
		location = path .. ":" .. vim.fn.line(".")
	end

	vim.ui.input({ prompt = "Note: " .. location .. " - " }, function(input)
		if input and input ~= "" then
			require("opencode.api").open_input():and_then(function()
				vim.schedule(function()
					require("opencode.ui.input_window")._append_to_input(location .. " - " .. input)
					vim.defer_fn(function()
						vim.cmd("stopinsert")
						if vim.api.nvim_win_is_valid(original_win) then
							vim.api.nvim_set_current_win(original_win)
						end
					end, 50)
				end)
			end)
		end
	end)
end

require("opencode").setup({
	default_mode = "plan",
	keymap = {
		editor = {
			["<leader>oi"] = false,
			["<leader>og"] = { "toggle", desc = "Opencode: toggle window" },
			["<leader>of"] = { "open_input", desc = "Opencode: open input" },
			["<leader>os"] = { "select_session", desc = "Opencode: select session" },
			["<leader>on"] = { "open_input_new_session", desc = "Opencode: new session" },
			["<leader>oa"] = { "agent", "select", desc = "Opencode: agent picker" },
			["<leader>op"] = { "configure_provider", desc = "Opencode: switch model" },
			["<leader>om"] = { "switch_mode", desc = "Opencode: cycle mode" },
			["<leader>cn"] = { opencode_note, desc = "Opencode: add note", mode = { "n", "v" } },
		},
		input_window = {
			["<M-m>"] = false, -- disable: conflicts with terminal
			["<esc>"] = false, -- disable: don't close on Esc
		},
		output_window = {
			["<esc>"] = false, -- disable: don't close on Esc
		},
	},
})
