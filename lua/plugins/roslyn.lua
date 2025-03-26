local M = {
	"seblj/roslyn.nvim",
	ft = "cs",
	opts = {
		config = {
			handlers = {
				["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded", max_width = 100 }),
				["textDocument/signatureHelp"] = vim.lsp.with(
					vim.lsp.handlers.signature_help,
					{ border = "rounded", max_width = 100 }
				),
			},
		},
	},
}

return M
