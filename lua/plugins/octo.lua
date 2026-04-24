local M = {
	"pwntester/octo.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"ibhagwan/fzf-lua",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		picker = "fzf-lua",
		enable_builtin = true,
	},
	keys = {
		{
			"<leader>op",
			"<CMD>Octo pr list<CR>",
			desc = "List GitHub PullRequests",
		},
	},
}

return M
