local M = {
	"CopilotC-Nvim/CopilotChat.nvim",
	branch = "main",
	dependencies = {
		{ "github/copilot.vim" },
		{ "nvim-lua/plenary.nvim", branch = "master" },
	},
	build = "make tiktoken",
	opts = {
		window = {
			layout = "vertical",
			-- width = 0.5,
			-- height = 0.5,
		},
	},
}

return M
