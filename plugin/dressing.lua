vim.pack.add({
	"https://github.com/stevearc/dressing.nvim",
})

require("dressing").setup({
	input = {
		override = function(conf)
			conf.relative = "editor"
			conf.width = 80
			conf.height = 1
			conf.row = math.floor(vim.go.lines * 0.6)
			conf.col = math.floor((vim.go.columns - conf.width) / 2)
			return conf
		end,
	},
	select = {
		backend = { "fzf_lua" },
		fzf_lua = {
			winopts = {
				fullscreen = false,
				height = 0.5,
				width = 0.5,
				preview = { hidden = "hidden" },
			},
		},
	},
})
