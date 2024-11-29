local header_long_string = [[
       ___   ___     
      /\  \ /\  \    
      \:\  \\:\  \   
  ___ /::\__\\:\  \  
 /\  /:/\/__//::\  \ 
 \:\/:/  /  /:/\:\__\
  \::/  /  /:/  \/__/
   \/__/  /:/  /     
          \/__/      
                     
]]
local header = {}
for line in header_long_string:gmatch("[^\r\n]+") do
	table.insert(header, line)
end

local M = {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	config = function()
		require("dashboard").setup({
			config = {
				header = header,
				project = { enable = false },
				mru = { limit = 10, cwd_only = true },
				shortcut = {
					{ desc = "[  Github]", group = "DashboardShortCut" },
					{ desc = "[  jtubbenhauer]", group = "DashboardShortCut" },
				},
				footer = {},
			},
		})
	end,
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
}

return {}
