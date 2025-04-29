local set = vim.keymap.set
local gs = require("gitsigns")

-- Fzf
set("n", "<leader>fz", ":lua require('fzf-lua').builtin({ winopts = { fullscreen=false, height=0.8, width=0.5 } })<cr>")
set("n", "<leader>sf", ":lua require('fzf-lua').files()<cr>")
set("n", "<leader>ss", ":lua require('fzf-lua').git_status()<cr>")
set("n", "<leader>sc", ":lua require('utils').fzf_git_changes()<cr>")
set("n", "<leader>qf", ":lua require('fzf-lua').quickfix()<cr>")
set("n", "<leader>sg", ":lua require('fzf-lua').live_grep()<cr>")
set("n", "<leader>so", ":lua require('fzf-lua').buffers()<cr>")
set("n", "<leader>sa", ":lua require('fzf-lua').resume()<cr>")
set("n", "<leader>sd", ":lua require('utils').fzf_dirs()<cr>")
set("n", "<leader>si", ":lua require('utils').grep_directory()<cr>")

-- File browser
set("n", "<leader>er", ":Oil .<cr>")
set("n", "<leader>ed", ":Oil<cr>")
set("n", "<leader>dc", ":lua require('utils').get_trimmed_cwd()<cr>")

-- LSP
set("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>")
set("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>")
set("n", "ge", ":lua vim.diagnostic.open_float()<CR>")
set("n", "gr", ":lua require('fzf-lua').lsp_references()<CR>")
set("n", "gd", ":lua require('fzf-lua').lsp_definitions()<CR>")

set("n", "<leader>fm", ":lua require('utils').format_buffer()<CR>")
vim.keymap.set("n", "<leader>ti", function()
	-- vim.b[bufnr].inlay_hints_enabled = not vim.b[bufnr].inlay_hints_enabled
	-- vim.lsp.inlay_hint(bufnr, vim.b[bufnr].inlay_hints_enabled)
	vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled(0))
end, { desc = "LSP: [T]oggle [I]nlay Hints" })

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

---- COC
---
-- Autocomplete
function _G.check_back_space()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

local keyset = vim.keymap.set
local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
keyset("i", "<C-j>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<C-j>" : coc#refresh()', opts)
keyset("i", "<C-k>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"]], opts)
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
keyset("n", "gd", "<Plug>(coc-definition)", { silent = true })
keyset("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
keyset("n", "gi", "<Plug>(coc-implementation)", { silent = true })
keyset("n", "gr", "<Plug>(coc-references)", { silent = true })

-- Use K to show documentation in preview window
function _G.show_docs()
	local cw = vim.fn.expand("<cword>")
	if vim.fn.index({ "vim", "help" }, vim.bo.filetype) >= 0 then
		vim.api.nvim_command("h " .. cw)
	elseif vim.api.nvim_eval("coc#rpc#ready()") then
		vim.fn.CocActionAsync("doHover")
	else
		vim.api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
	end
end
keyset("n", "K", "<CMD>lua _G.show_docs()<CR>", { silent = true })
-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
	group = "CocGroup",
	command = "silent call CocActionAsync('highlight')",
	desc = "Highlight symbol under cursor on CursorHold",
})

-- Symbol renaming
keyset("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true })

keyset("i", "<C-a>", "coc#refresh()", opts)
keyset("n", "[d", "<Plug>(coc-diagnostic-prev)", { silent = true })
keyset("n", "]d", "<Plug>(coc-diagnostic-next)", { silent = true })
keyset("n", "<leader>ca", "<cmd>Telescope coc code_actions<cr>")
-- keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)
