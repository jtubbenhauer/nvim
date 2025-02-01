local M = {
	-- dir = "~/dev/nvim-plugins/dressing.nvim",
	"stevearc/dressing.nvim",
	config = function()
		require("dressing").setup({
			select = {
				backend = { "fzf_lua" },
				fzf_lua = {
					winopts = {
						fullscreen = false,
						height = 0.5,
						width = 0.5,
						preview = {
							hidden = "hidden",
						},
					},
				},
			},
		})
	end,
}

return M
