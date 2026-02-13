local M = {
	{
		"saghen/blink.cmp",
		dependencies = "rafamadriz/friendly-snippets",

		version = "1.*",

		opts = {
			keymap = {
				preset = "default",
				["<C-j>"] = { "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },
				["<Enter>"] = { "select_and_accept", "fallback" },
				["<C-a>"] = { "show" },
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "lsp", "buffer" },
				providers = {
					lsp = {
						async = true,
					},
				},
			},
			fuzzy = { implementation = "rust" },
			signature = { enabled = true },
			completion = {
				trigger = {
					show_on_blocked_trigger_characters = { "{", "}", " ", "\n", "\t" },
				},
			},
		},
		opts_extend = { "sources.default" },
	},
}

return M
