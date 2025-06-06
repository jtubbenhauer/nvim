local server_configs = {
	vtsls = {
		filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "htmlangular" },
		settings = {
			complete_function_calls = true,
			vtsls = {
				autoUseWorkspaceTsdk = true,
				experimental = {
					completion = {
						enableServerSideFuzzyMatch = true,
					},
				},
			},
			typescript = {
				tsserver = {
					maxTsServerMemory = 11000,
				},
			},
		},
	},
	-- eslint = {
	-- 	filetypes = { "javascript", "html", "javascriptreact", "typescript", "typescriptreact", "htmlangular" },
	-- },
	lua_ls = {
		lua_ls = {
			settings = {
				Lua = {
					completion = {
						callSnippet = "Replace",
					},
					diagnostics = { disable = { "missing-fields" }, globals = { "vim" } },
				},
			},
		},
	},
	angularls = {
		on_init = function(client)
			client.server_capabilities.renameProvider = false
		end,
	},
}

local M = {
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup({
				registries = {
					"github:mason-org/mason-registry",
					"github:Crashdummyy/mason-registry",
				},
			})
		end,
	},

	{ "mason-org/mason-lspconfig.nvim", opts = {} },

	{
		"neovim/nvim-lspconfig",
		dependencies = { "j-hui/fidget.nvim", opts = {} },
		config = function()
			for server, config in pairs(server_configs) do
				vim.lsp.config(server, config)
			end
		end,
	},
}

return M
