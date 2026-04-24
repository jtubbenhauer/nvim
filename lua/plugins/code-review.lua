local M = {
	"jtubbenhauer/code-review.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim", -- optional but recommended
		"nvim-tree/nvim-web-devicons", -- optional
		{ "axkirillov/unified.nvim", opts = {} }, -- optional, for inline diff view
	},
	cmd = { "Review", "ReviewLocal", "ReviewClose", "ReviewRefresh" },
	keys = {
		{ "<leader>cr", "<cmd>Review<cr>", desc = "Start code review" },
		{ "<leader>crl", "<cmd>ReviewLocal<cr>", desc = "Review local changes" },
		{ "<leader>crc", "<cmd>ReviewClose<cr>", desc = "Close code review" },
		{ "<leader>crr", "<cmd>ReviewRefresh<cr>", desc = "Refresh code review" },
		{
			"<leader>crn",
			function()
				require("code-review").mark_and_next()
			end,
			desc = "Mark reviewed & next",
		},
		{
			"<leader>crm",
			function()
				require("code-review").toggle_reviewed()
			end,
			desc = "Toggle reviewed",
		},
		{
			"<leader>cru",
			function()
				require("code-review").next_unreviewed()
			end,
			desc = "Next unreviewed",
		},
		{
			"<leader>crd",
			function()
				require("code-review").toggle_unified_diff()
			end,
			desc = "Toggle unified diff",
		},
	},
	opts = {},
}

return M
