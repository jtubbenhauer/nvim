local o = vim.o
local wo = vim.wo
local g = vim.g

-- wezterm only!
local function paste()
	return {
		vim.fn.split(vim.fn.getreg(""), "\n"),
		vim.fn.getregtype(""),
	}
end

-- if vim.env.SSH_TTY then
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
-- end

g.mapleader = " "
o.hlsearch = false
wo.number = true
o.mouse = "a"
o.clipboard = "unnamedplus"
o.breakindent = true
o.ignorecase = true
o.smartcase = true
wo.signcolumn = "yes"
o.updatetime = 250
o.timeout = true
o.timeoutlen = 1000
o.completeopt = "menuone,noselect"
o.termguicolors = true
o.relativenumber = true
o.scrolloff = 15
o.incsearch = true
o.autoindent = true
o.expandtab = true
o.tabstop = 2
o.shiftwidth = 2
wo.cursorline = true
o.swapfile = false
o.showtabline = 1

vim.opt.fillchars = {
	diff = " ",
}

vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	float = {
		border = "single",
	},
})
