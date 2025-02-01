local M = {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				typescriptreact = { "prettierd" },
				html = { "prettierd" },
				htmlangular = { "prettierd" },
				css = { "prettierd" },
				scss = { "prettierd" },
				sass = { "prettierd" },
				xml = { "xmlformatter" },
				python = { "black" },
				go = { "gopls", "golines" },
				json = { "prettierd" },
				jsonc = { "prettierd" },
				cpp = { "clang-format" },
				yaml = { "prettierd" },
				yml = { "prettierd" },
				cs = { "csharpier" },
				rust = { "rustfmt" },
			},
			notify_on_error = false,
			format_on_save = {
				timeout_ms = 1000,
				lsp_fallback = "fallback",
			},
		})
	end,
}

return M
