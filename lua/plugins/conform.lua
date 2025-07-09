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
				typescriptreact = { "prettierd" },
				markdown = { "prettierd" },
				html = { "prettierd" },
				htmlangular = { "prettierd" },
				css = { "prettierd" },
				scss = { "prettierd" },
				sass = { "prettierd" },
				xml = { "xmlformatter" },
				python = { "black" },
				go = { "golines" },
				json = { "prettierd" },
				jsonc = { "prettierd" },
				cpp = { "clang-format" },
				yaml = { "prettierd" },
				yml = { "prettierd" },
				cs = { "csharpier" },
				rust = { "rustfmt" },
			},
			formatters = {
				csharpier = function()
					local useDotnet = not vim.fn.executable("csharpier")

					local command = useDotnet and "dotnet csharpier" or "csharpier"

					local version_out = vim.fn.system(command .. " --version")

					-- vim.notify(version_out)

					--NOTE: system command returns the command as the first line of the result, need to get the version number on the final line
					local version_result = version_out[#version_out]
					local major_version = tonumber((version_out or ""):match("^(%d+)")) or 0
					local is_new = major_version >= 1

					-- vim.notify(tostring(is_new))

					local args = is_new and { "format", "$FILENAME" } or { "--write-stdout" }

					return {
						command = command,
						args = args,
						stdin = not is_new,
						require_cwd = false,
					}
				end,
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
