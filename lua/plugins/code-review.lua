-- code-review.nvim plugin spec for lazy.nvim
return {
	"jtubbenhauer/code-review.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim",
		"nvim-tree/nvim-web-devicons",
		{ "axkirillov/unified.nvim", opts = {} },
	},
	opts = {},
	keys = {
		{ "<leader>cr", "<cmd>Review<cr>", desc = "Start code review" },
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
	cmd = { "Review", "ReviewClose", "ReviewRefresh" },
}
