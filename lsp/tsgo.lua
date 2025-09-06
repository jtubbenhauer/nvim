---@type vim.lsp.Config
return {
	cmd = { "tsgo", "--lsp", "--stdio" },
	filetypes = {
		"angularhtml",
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	root_markers = {
		"tsconfig.json",
		-- "jsconfig.json",
		-- "package.json",
		".git",
		-- "tsconfig.base.json",
	},
}
