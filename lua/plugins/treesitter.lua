local M = {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	-- dependencies = { "elgiano/nvim-treesitter-angular", branch = "topic/jsx-fix" },
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "typescript", "html" },
			highlight = { enable = true },
			auto_install = true,
			cond = function(_, bufnr)
				return not api.nvim_buf_line_count(bufnr) > 2000
			end,
			autotag = {
				enable_close_on_slash = false,
			},
		})
	end,
}
return M
