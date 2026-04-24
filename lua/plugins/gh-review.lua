local M = {
	dir = "~/dev/gh-review.nvim",
	dependencies = {
		"sindrets/diffview.nvim",
		"ibhagwan/fzf-lua",
	},
	cmd = { "GhReview", "GhReviewClose", "GhReviewRefresh" },
	keys = {
		{ "<leader>gr", "<cmd>GhReview<cr>", desc = "GitHub PR review" },
		{ "<leader>grc", "<cmd>GhReviewClose<cr>", desc = "Close PR review" },
		{ "<leader>grr", "<cmd>GhReviewRefresh<cr>", desc = "Refresh PR review" },
	},
	opts = {},
}

return M
