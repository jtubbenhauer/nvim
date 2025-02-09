local M = {}

function M.git_changes(opts, ctx)
	return require("snacks.picker.source.proc").proc({
		opts,
		{
			cmd = "git",
			args = { "diff", "--name-only", "origin/HEAD" },
			transform = function(item)
				item.file = item.text
			end,
		},
	}, ctx)
end

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		bigfile = { enabled = true },
		indent = { enabled = false, only_scope = true, only_current = true, animate = { enabled = false } },
		input = { enabled = true },
		picker = {
			enabled = true,
			formatters = {
				file = {
					filename_first = true,
					truncate = 100,
				},
			},
		},
		notifier = { enabled = false },
		quickfile = { enabled = true },
		words = { enabled = true },
	},
	keys = {
		{
			"<leader>sf",
			function()
				Snacks.picker.files()
			end,
		},
		{
			"<leader>ss",
			function()
				Snacks.picker.git_status()
			end,
		},
		{
			"<leader>sg",
			function()
				Snacks.picker.grep()
			end,
		},
		{
			"<leader>so",
			function()
				Snacks.picker.buffers()
			end,
		},
		{
			"<leader>sp",
			function()
				Snacks.picker.pickers()
			end,
		},
		{
			"gr",
			function()
				Snacks.picker.lsp_references()
			end,
			nowait = true,
		},
		{
			"sc",
			function()
				Snacks.picker({
					finder = M.git_changes,
					confirm = function(picker, item)
						picker:close()
						vim.cmd("edit " .. item.file)
					end,
				})
			end,
		},
	},
}
