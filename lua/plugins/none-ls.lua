local M = {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		require("null-ls").setup({
			sources = {
				require("none-ls.code_actions.eslint_d"),
			},
		})
	end,
}

return M
