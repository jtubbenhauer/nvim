local M = {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local eslint_d_filetypes = {
			"htmlangular",
			"html",
			"typescript",
			"typescriptreact",
			"javascript",
			"javascriptreact",
		}
		require("null-ls").setup({
			sources = {
				require("none-ls.code_actions.eslint_d").with({
					filetypes = eslint_d_filetypes,
				}),
				require("none-ls.diagnostics.eslint_d").with({
					filetypes = eslint_d_filetypes,
				}),
			},
		})
	end,
}

return {}
