local M = {

	"mfussenegger/nvim-lint",

	config = function()
		vim.env.ESLINT_D_PPID = vim.fn.getpid()

		require("lint").linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			html = { "eslint_d" },
			htmlangular = { "eslint_d" },
		}

		-- local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}

return {}
