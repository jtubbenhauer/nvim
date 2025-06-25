vim.cmd([[
augroup highlight_yank
autocmd!
au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
augroup END
]])

vim.api.nvim_create_user_command("VS", function(opts)
	vim.cmd("vert rightb " .. opts.args)
end, { nargs = 1 })

vim.cmd([[
au WinNew * au BufEnter * ++once
  \ if (&bt ==? 'help' || &ft ==? 'man')
  \ && winwidth(winnr('#')) >= 180 | wincmd L | endif
]])

-- Format on save

vim.g.format_on_save = true
local format_group = vim.api.nvim_create_augroup("MyFormatOnSave", { clear = true })
local format_file_patterns = {
	"*.asm",
	"*.lua",
	"*.astro",
	"*.js",
	"*.jsx",
	"*.ts",
	"*.tsx",
	"*.md",
	"*.html",
	"*.css",
	"*.scss",
	"*.sass",
	"*.xml",
	"*.py",
	"*.go",
	"*.json",
	"*.jsonc",
	"*.cpp",
	"*.yaml",
	"*.yml",
	"*.cs",
	"*.rs",
}

vim.api.nvim_create_autocmd("BufWritePre", {
	group = format_group,
	pattern = format_file_patterns,
	callback = function()
		if not vim.g.format_on_save then
			return
		end

		local ft = vim.bo.filetype:gsub("react$", "")
		if ft == "typescript" then
			local ok = vim.lsp.buf_request_sync(0, "workspace/executeCommand", {
				command = "typescript.organizeImports",
				arguments = { vim.api.nvim_buf_get_name(0) },
			}, 3000)
			if not ok then
				print("Organise imports timeout or failed to complete.")
			end
		end

		require("conform").format({ async = false })
	end,
})

vim.api.nvim_create_user_command("ToggleFormatOnSave", function()
	vim.g.format_on_save = not vim.g.format_on_save
	print("Format on save " .. (vim.g.format_on_save and "enabled" or "disabled"))
end, { desc = "Toggle format on save" })
