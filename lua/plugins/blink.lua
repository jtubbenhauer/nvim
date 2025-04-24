local M = {
	"saghen/blink.cmp",
	dependencies = "rafamadriz/friendly-snippets",

	version = "*",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		enabled = function()
			return not vim.tbl_contains({ "markdown" }, vim.bo.filetype)
		end,
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
			default = { "lsp", "path" },
		},
		-- "snippets""buffer"
		fuzzy = { implementation = "prefer_rust_with_warning" },
		signature = { enabled = true },
		completion = {
			trigger = {
				show_on_blocked_trigger_characters = { "{", "}", " ", "\n", "\t" },
			},
		},
	},
	opts_extend = { "sources.default" },
}

return {}
