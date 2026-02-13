local M = {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				asm = { "asmfmt" },
				lua = { "stylua" },
				astro = { "prettier" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				typescriptreact = { "prettier" },
				markdown = { "prettierd" },
				html = { "prettierd" },
				elixir = { "mix" },
				eelixir = { "mix" },
				heex = { "mix" },
				surface = { "mix" },
				htmlangular = { "prettierd" },
				css = { "prettierd" },
				scss = { "prettierd" },
				sass = { "prettierd" },
				xml = { "xmlformatter" },
				proto = { "clang-format" },
				python = { "black" },
				go = { "golines" },
				json = { "prettierd" },
				jsonc = { "prettierd" },
				cpp = { "clang-format" },
				yaml = { "prettierd" },
				yml = { "prettierd" },
				cs = { "csharpier" },
				rust = { "rustfmt" },
				svelte = { "prettierd" },
			},
			formatters = {
				-- csharpier = function()
				-- 	local useDotnet = not vim.fn.executable("csharpier")
				--
				-- 	local command = useDotnet and "dotnet csharpier" or "csharpier"
				--
				-- 	local version_out = vim.fn.system(command .. " --version")
				--
				-- 	-- vim.notify(version_out)
				--
				-- 	--NOTE: system command returns the command as the first line of the result, need to get the version number on the final line
				-- 	local version_result = version_out[#version_out]
				-- 	local major_version = tonumber((version_out or ""):match("^(%d+)")) or 0
				-- 	local is_new = major_version >= 1
				--
				-- 	-- vim.notify(tostring(is_new))
				--
				-- 	local args = is_new and { "format", "$FILENAME" } or { "--write-stdout" }
				--
				-- 	return {
				-- 		command = command,
				-- 		args = args,
				-- 		stdin = not is_new,
				-- 		require_cwd = false,
				-- 	}
				-- end,
			},
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable with a global or buffer-local variable
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return { timeout_ms = 2000, lsp_format = "fallback" }
			end,
		})
	end,
}

vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		-- FormatDisable! will disable formatting just for this buffer
		vim.b.disable_autoformat = true
	else
		vim.g.disable_autoformat = true
	end
end, {
	desc = "Disable autoformat-on-save",
	bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
end, {
	desc = "Re-enable autoformat-on-save",
})

return M
