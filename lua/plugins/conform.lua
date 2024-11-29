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
				timeout_ms = 500,
				lsp_fallback = "fallback",
			},
			-- format_on_save = function(bufnr)
			-- 	if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			-- 		return
			-- 	end
			-- 	return { timeout_ms = 2000, lsp_fallback = true }
			-- end,
		})
	end,
}

return M
