local M = {
	"projekt0n/github-nvim-theme",
	name = "github-theme",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		require("github-theme").setup({
			options = {
				hide_nc_statusline = false,
			},
			groups = {
				github_dark_default = {
					CursorLine = { bg = "#272b30" },
					FloatBorder = { fg = "#d9d9d9" },
				},
			},
		})

		vim.cmd("colorscheme github_dark_default")
	end,
}

return M
