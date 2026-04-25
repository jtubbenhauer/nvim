vim.loader.enable()
vim.deprecate = function() end

vim.g.mapleader = " "

-- Clipboard (OSC 52)
local function paste()
	return {
		vim.fn.split(vim.fn.getreg(""), "\n"),
		vim.fn.getregtype(""),
	}
end

vim.g.clipboard = {
	name = "OSC 52",
	copy = {
		["+"] = require("vim.ui.clipboard.osc52").copy("+"),
		["*"] = require("vim.ui.clipboard.osc52").copy("*"),
	},
	paste = {
		["+"] = paste,
		["*"] = paste,
	},
}

-- Options
vim.o.hlsearch = false
vim.o.number = true
vim.o.mouse = "a"
vim.o.clipboard = "unnamedplus"
vim.o.breakindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = "yes"
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 1000
vim.o.completeopt = "menuone,noselect"
vim.o.termguicolors = true
vim.o.relativenumber = true
vim.o.scrolloff = 15
vim.o.incsearch = true
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.cursorline = true
vim.o.swapfile = false
vim.o.showtabline = 1
vim.o.winborder = "rounded"
vim.o.undofile = true

vim.opt.fillchars = { diff = " " }

-- Disable inotifywait file watching (inotify limit issues on large projects)
vim._watch.inotify = function()
	return function() end
end

-- Diagnostics
vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	float = { border = "single" },
})

-- ui2
require("vim._core.ui2").enable({})

-- vim.pack hooks (must be before any vim.pack.add() for install-hook robustness)
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and kind == "update" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
	end,
})

-- Autocmds
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

-- Open help and man in a vertical split if the window is wide enough
vim.cmd([[au WinNew * au BufEnter * ++once
  \ if (&bt ==? 'help' || &ft ==? 'man')
  \ && winwidth(winnr('#')) >= 180 | wincmd L | endif
]])

-- User commands
vim.api.nvim_create_user_command("ToggleDark", function()
	if vim.g.colors_name == "github_dark_default" then
		vim.cmd("colorscheme github_light_high_contrast")
	else
		vim.cmd("colorscheme github_dark_default")
	end
end, { nargs = 0 })
