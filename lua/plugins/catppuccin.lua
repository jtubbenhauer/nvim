local M = {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,

	config = function()
		require("catppuccin").setup({
			-- dim_inactive = {
			-- 	enabled = true,
			-- 	percentage = 0.05,
			-- },
			no_italic = true,
			-- transparent_background = true,
			-- color_overrides = {
			-- 	all = {
			-- 		base = "#14141f",
			-- 		mantle = "#101019",
			-- 		crust = "#0b0b12",
			-- 	},
			-- },
		})
		-- vim.cmd([[colorscheme catppuccin-mocha]])
	end,
}

return {}
