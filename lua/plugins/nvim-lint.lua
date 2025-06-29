local M = {
	"mfussenegger/nvim-lint",
	config = function()
		require("lint").linters_by_ft = {
			-- typescript = { "eslint_d" },
			-- htmlangular = { "eslint_d" },
			typescript = { "biomejs" },
			htmlangular = { "biomejs" },
		}
	end,
}

return M
