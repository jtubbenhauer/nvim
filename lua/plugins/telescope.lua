local M = {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"fannheyward/telescope-coc.nvim",
	},
	config = function()
		local actions = require("telescope.actions")

		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
				},
			},
			shorten_path = true,
			extensions = {
				coc = {
					theme = "ivy",
					prefer_locations = true,
					push_cursor_on_edit = true,
					timeout = 10000,
				},
			},
		})

		require("telescope").load_extension("coc")
	end,
}

return M
