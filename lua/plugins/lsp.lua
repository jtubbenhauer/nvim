local server_configs = {
	vtsls = {
		filetypes = { "javascript", "astro", "javascriptreact", "typescript", "typescriptreact", "htmlangular" },
		settings = {
			complete_function_calls = true,
			vtsls = {
				autoUseWorkspaceTsdk = true,
				experimental = {
					completion = {
						enableServerSideFuzzyMatch = true,
						entriesLimit = 20,
					},
				},
			},
			typescript = {
				tsserver = {
					maxTsServerMemory = 16000,
				},
			},
		},
	},
	elixirls = {
		cmd = { "/home/jack/.local/share/nvim/mason/packages/elixir-ls/language_server.sh" },
	},
	tailwindcss = {
		filetypes = {
			"html",
			"htmlangular",
		},
	},
	emmet_ls = {
		filetypes = {
			"html",
			"htmlangular",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"elixir",
			"eelixir",
			"heex",
			"surface",
		},
	},
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
		filetypes = { "typescript", "html", "htmlangular" },
		on_init = function(client)
			client.server_capabilities.renameProvider = false
		end,
	},
	astro = {},
	tsgo = {
		filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
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
		dependencies = { "j-hui/fidget.nvim" },
		opts = {},
		config = function()
			for server, config in pairs(server_configs) do
				vim.lsp.config(server, config)
			end
		end,
	},
}

return M
