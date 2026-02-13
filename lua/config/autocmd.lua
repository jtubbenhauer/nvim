vim.cmd([[
augroup highlight_yank
autocmd!
au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
augroup END
]])

vim.api.nvim_create_user_command("VS", function(opts)
	vim.cmd("vert rightb " .. opts.args)
end, { nargs = 1 })

vim.api.nvim_create_user_command("ToggleDark", function()
	local current_scheme = vim.g.colors_name
	if current_scheme == "github_dark_default" then
		vim.cmd("colorscheme github_light_high_contrast")
	else
		vim.cmd("colorscheme github_dark_default")
	end
end, { nargs = 0 })

vim.cmd([[
au WinNew * au BufEnter * ++once
  \ if (&bt ==? 'help' || &ft ==? 'man')
  \ && winwidth(winnr('#')) >= 180 | wincmd L | endif
]])

-- Format on save

local organise_imports_v2 = function()
	local ft = vim.bo.filetype
	if ft == "typescript" or ft == "typescriptreact" or ft == "javascript" or ft == "javascriptreact" then
		local file = vim.fn.expand("%:p")
		vim.cmd("update")

		local cmd
		if vim.fn.executable("organize-imports-cli") == 1 then
			cmd = "organize-imports-cli " .. vim.fn.shellescape(file)
		else
			cmd = "npx organize-imports-cli " .. vim.fn.shellescape(file)
		end

		local output = vim.fn.system(cmd)

		if vim.v.shell_error ~= 0 then
			print("Organize Imports Failed: " .. output)
		else
			vim.cmd("edit!")
		end
	end
end

local organise_imports = function()
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
end

-- eslint_d

-- local organise_imports = function()
-- 	local ft = vim.bo.filetype:gsub("react$", "")
-- 	if ft == "typescript" or ft == "javascript" then
-- 		vim.lsp.buf.format({
-- 			filter = function(client)
-- 				return client.name == "null-ls"
-- 			end,
-- 			async = false,
-- 		})
-- 	end
-- end

vim.api.nvim_create_user_command("OrganiseImports", function()
	organise_imports()
end, { desc = "Sort TS imports" })

vim.api.nvim_create_user_command("ToggleFormatOnSave", function()
	vim.g.format_on_save = not vim.g.format_on_save
	print("Format on save " .. (vim.g.format_on_save and "enabled" or "disabled"))
end, { desc = "Toggle format on save" })

-- goto definition with ctags, fallback to lsp
local smart_goto_definition = function()
	local word = vim.fn.expand("<cword>")

	if word == "" then
		print("No word under cursor")
		return
	end

	-- Try ctags first
	local tags_output = vim.fn.system("tag " .. word .. " 2>/dev/null")
	local tags_exists = vim.v.shell_error == 0 and tags_output:match("%S")

	if tags_exists then
		-- ctags found the tag, use it
		vim.cmd("tag " .. word)
	else
		-- ctags failed, try LSP
		local clients = vim.lsp.get_active_clients({ bufnr = 0 })

		if #clients > 0 then
			-- LSP is available, use it
			vim.lsp.buf.definition()
		else
			-- No LSP available either
			print("No definition found for '" .. word .. "'")
		end
	end
end

vim.api.nvim_create_user_command("GoToDefinition", function()
	smart_goto_definition()
end, { desc = "Sort TS imports" })
