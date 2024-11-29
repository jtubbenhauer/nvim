local M = {
	"CopilotC-Nvim/CopilotChat.nvim",
	branch = "canary",
	dependencies = {
		{ "github/copilot.vim" }, -- or github/copilot.vim
		{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
	},
	opts = {
		debug = false, -- Enable debugging
		-- See Configuration section for rest

		window = {
			layout = "vertical",
			-- width = 0.5,
			-- height = 0.5,
		},
	},
}
return M
