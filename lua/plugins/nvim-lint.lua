local M = {
	"mfussenegger/nvim-lint",

	config = function()
		vim.env.ESLINT_D_PPID = vim.fn.getpid()

		require("lint").linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			html = { "eslint_d" },
		}

		-- local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				-- try_lint without arguments runs the linters defined in `linters_by_ft`
				-- for the current filetype
				require("lint").try_lint()

				-- You can call `try_lint` with a linter name or a list of names to always
				-- run specific linters, independent of the `linters_by_ft` configuration
				-- require("lint").try_lint("cspell")
			end,
		})
	end,
}

return M