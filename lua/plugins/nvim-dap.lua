local M = {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require("dap")
		local ui = require("dapui")

		require("dapui").setup()

		dap.adapters.firefox = {
			type = "executable",
			command = "node",
			args = {
				os.getenv("HOME") .. "/.local/share/nvim/mason/packages/firefox-debug-adapter/dist/adapter.bundle.js",
			},
		}

		dap.configurations.typescript = {
			{
				name = "Debug with Firefox",
				type = "firefox",
				request = "launch",
				reAttach = true,
				url = "http://localhost:4200",
				webRoot = "${workspaceFolder}",
				-- firefoxExecutable = "/mnt/c/Program Files/Firefox Developer Edition/firefox.exe",
				firefoxExecutable = "/mnt/c/Windows/System32/cmd.exe",
				firefoxArgs = {
					"/c",
					"start",
					"",
					"C:\\Program Files\\Firefox Developer Edition\\firefox.exe",
					"--new-instance",
					"--no-remote",
					"--temp-profile",
				},
			},
		}

		-- dap.adapters["pwa-node"] = {
		-- 	type = "server",
		-- 	host = "localhost",
		-- 	port = "${port}",
		-- 	executable = {
		-- 		command = "node",
		-- 		args = { "/home/jack/.local/share/nvim/mason/packages/js-debug-adapter/src/dapDebugServer.js" },
		-- 	},
		-- }
	end,
}

return M
