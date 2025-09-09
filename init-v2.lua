-- --- LAZY --- --

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
	change_detection = {
		notify = false,
	},
})

-- --- OPTIONS --- --

local o = vim.o
local wo = vim.wo
local g = vim.g
local opt = vim.opt

g.mapleader = " "
o.hlsearch = false
o.mouse = "a"
o.clipboard = "unnamedplus"
o.breakindent = true
o.ignorecase = true
o.smartcase = true
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
o.swapfile = false
o.showtabline = 1
o.winborder = "rounded"
o.undofile = true
wo.number = true
wo.cursorline = true
wo.signcolumn = "yes"

opt.fillchars = {
	diff = " ",
}

vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	float = {
		border = "single",
	},
})

-- --- KEYMAP --- --

local set = vim.keymap.set
local gs = require("gitsigns")

-- Fzf

set("n", "<leader>fz", ":lua require('fzf-lua').builtin({ winopts = { fullscreen=false, height=0.8, width=0.5 } })<cr>")
set("n", "<leader>sf", ":lua require('fzf-lua').files()<cr>")
set("n", "<leader>sw", ":lua require('fzf-lua').grep_cword()<cr>")
set("n", "<leader>ss", ":lua require('fzf-lua').git_status()<cr>")
set("n", "<leader>sc", ":lua require('utils').fzf_git_changes()<cr>")
set("n", "<leader>sg", ":lua require('fzf-lua').live_grep()<cr>")
set("n", "<leader>so", ":lua require('fzf-lua').buffers()<cr>")
set("n", "<leader>sa", ":lua require('fzf-lua').resume()<cr>")
set("n", "<leader>sd", ":lua require('utils').fzf_dirs()<cr>")
set("n", "<leader>si", ":lua require('utils').grep_directory()<cr>")

-- Oil

set("n", "<leader>er", ":Oil .<cr>")
set("n", "<leader>ed", ":Oil<cr>")
set("n", "<leader>dc", ":lua require('utils').get_trimmed_cwd()<cr>")

-- LSP

set("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>")
set("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>")
set("n", "ge", ":lua vim.diagnostic.open_float()<CR>")
set("n", "gr", ":lua require('fzf-lua').lsp_references()<CR>")
set("n", "gd", ":lua require('fzf-lua').lsp_definitions()<CR>")
set("n", "<leader>oi", "<cmd>OrganiseImports<CR>")

-- General

set("n", "<C-s>", "<cmd>w<cr>")
set({ "i", "v" }, "<C-s>", "<Esc><cmd>w<cr>")
set("n", "<leader>vs", "<cmd>vs<CR><cmd>wincmd l<CR>")
set("n", "<leader>ct", "<cmd>tabclose<CR>")
set("n", "<leader>cb", "<cmd>q<cr>")
set("n", "<C-e>", "2<C-e>")
set("n", "<C-y>", "2<C-y>")
set({ "n", "i", "v" }, "<C-h>", ":vertical resize -5<CR>")
set({ "n", "i", "v" }, "<C-l>", ":vertical resize +5<CR>")
set("n", "<leader>ci", ":Inspect<CR>")
set("n", "<leader>sv", ":SSave default<CR>")
set("n", "<leader>sl", ":SLoad default<CR>")
set("n", "<leader>ft", ":ToggleFormatOnSave<CR>")
set("n", "<leader>cd", ":lua require('utils').copy_buffer_dir()<cr>")

-- Diffview

set("n", "<leader>ds", ":lua require('utils').toggle_diffview_status()<CR>")
set("n", "<leader>db", ":lua require('utils').toggle_diffview_branch()<CR>")
set("n", "<leader>dh", ":DiffviewFileHistory %<CR>")
set("n", "<leader>dvfh", "<cmd>DiffviewFileHistory %<cr>")

-- ChatGPT

set("n", "<leader>cpc", ":lua require('utils').copilot_chat()<cr>")
set("n", "<leader>cpt", ":lua require('utils').copilot_chat_toggle()<cr>")
set("n", "<leader>cpe", "<cmd>Copilot enable<cr>")
set("n", "<leader>cpd", "<cmd>Copilot disable<cr>")

-- Aerial

set("n", "<leader>ae", ":AerialToggle<cr>")

-- Spectre

set("n", "<leader>sr", ":lua require('spectre').toggle()<cr>")

-- Git

set("n", "<leader>hr", gs.reset_hunk)
set("n", "<leader>gsb", ":lua require('utils').change_git_signs_base()<cr>")
set("n", "<leader>gstb", gs.toggle_current_line_blame)
set("n", "<leader>hs", gs.stage_hunk)

-- Undotree

set("n", "<leader>ut", ":UndotreeToggle<cr>:UndotreeFocus<cr>")
