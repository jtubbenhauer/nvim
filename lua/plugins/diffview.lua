local M = {
	"sindrets/diffview.nvim",
	config = function()
		local actions = require("diffview.actions")

		require("diffview").setup({
			-- keymaps = {
			-- 	file_panel = {
			-- 		["gf"] = function()
			-- 			actions.goto_file()
			-- 			vim.cmd("tabo")
			-- 			vim.cmd("q")
			-- 		end,
			-- 	},
			-- },
		})
	end,
}

return M
