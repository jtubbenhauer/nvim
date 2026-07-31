vim.pack.add({
	"https://github.com/max397574/better-escape.nvim",
})

require("better_escape").setup({
	mappings = {
		v = {
			j = {
				k = false,
			},
		},
		s = {
			j = {
				k = false,
			},
		},
	},
})
