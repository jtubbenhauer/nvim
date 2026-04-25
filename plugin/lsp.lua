vim.pack.add({
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/j-hui/fidget.nvim",
})

require("mason").setup({
	registries = {
		"github:mason-org/mason-registry",
		"github:Crashdummyy/mason-registry",
	},
})

require("mason-lspconfig").setup()
require("fidget").setup()

-- vim.lsp.enable({
-- 	"tsgo",
-- })

local organise_imports = function()
	vim.lsp.buf.code_action({
		context = { only = { "source.organizeImports" }, diagnostics = {} },
		apply = true,
	})
end

vim.api.nvim_create_user_command("OrganiseImports", organise_imports, { desc = "Organise imports" })

local set = vim.keymap.set
set("n", "<leader>rn", vim.lsp.buf.rename)
set("n", "<leader>ca", vim.lsp.buf.code_action)
set("n", "ge", vim.diagnostic.open_float)
set("n", "<leader>oi", "<cmd>OrganiseImports<CR>")
