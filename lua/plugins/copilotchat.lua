local M = {
	"CopilotC-Nvim/CopilotChat.nvim",
	branch = "main",
	dependencies = {
		{ "github/copilot.vim" },
		{ "nvim-lua/plenary.nvim", branch = "master" },
	},
	build = "make tiktoken",
	opts = {
		model = "claude-sonnet-4",
		temperature = 0.1,
		window = {
			layout = "vertical",
			-- width = 0.5,
			-- height = 0.5,
		},
	},
}

return {}
