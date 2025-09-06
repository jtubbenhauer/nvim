local M = {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("fzf-lua").setup({
			defaults = {
				formatter = "path.filename_first",
			},
			keymap = {
				fzf = {
					["ctrl-d"] = "half-page-down",
					["ctrl-u"] = "half-page-up",
				},
			},
			winopts = {
				-- fullscreen = true,
				preview = {
					layout = "horizontal",
					horizontal = "right:40%",
				},
				height = 0.90,
				width = 0.85,
			},
			grep = {
				rg_glob = true,
				glob_flag = "--iglob", -- for case sensitive globs use '--glob'
				glob_separator = "%s%-%-", -- query separator pattern (lua): ' --'
			},
		})

		require("fzf-lua").register_ui_select()
	end,
}

return M
