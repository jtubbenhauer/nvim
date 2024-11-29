local set = vim.keymap.set
local add = require("selfhelp").add
local gs = require("gitsigns")

-- Fzf

set("n", "<leader>fz", ":lua require('fzf-lua').builtin({ winopts = { fullscreen=false, height=0.8, width=0.5 } })<cr>")
add({
	mode = "n",
	lhs = "<leader>sf",
	rhs = ":lua require('fzf-lua').files()<cr>",
	desc = "Search files",
	category = "Search",
})
add({
	mode = "n",
	lhs = "<leader>ss",
	rhs = ":lua require('fzf-lua').git_status()<cr>",
	desc = "Search git status",
	category = "Search",
})
add({
	mode = "n",
	lhs = "<leader>sc",
	rhs = ":lua require('utils').fzf_git_changes()<cr>",
	desc = "Search git changes",
	category = "Search",
})
add({
	mode = "n",
	lhs = "<leader>qf",
	rhs = ":lua require('fzf-lua').quickfix()<cr>",
	desc = "Search quickfix",
	category = "Search",
})
add({
	mode = "n",
	lhs = "<leader>sg",
	rhs = ":lua require('fzf-lua').live_grep()<cr>",
	desc = "Search live grep",
	category = "Search",
})
add({
	mode = "n",
	lhs = "<leader>so",
	rhs = ":lua require('fzf-lua').buffers()<cr>",
	desc = "Search recent files",
	category = "Search",
})
add({
	mode = "n",
	lhs = "<leader>sa",
	rhs = ":lua require('fzf-lua').resume()<cr>",
	desc = "Resume last search",
	category = "Search",
})
add({
	mode = "n",
	lhs = "<leader>sd",
	rhs = ":lua require('utils').fzf_dirs()<cr>",
	desc = "Search directory",
	category = "Search",
})
add({
	mode = "n",
	lhs = "<leader>si",
	rhs = ":lua require('utils').grep_directory()<cr>",
	desc = "Grep in directory",
	category = "Search",
})

add({
	mode = "n",
	lhs = "<leader>qq",
	rhs = ":SelfHelp<cr>",
	desc = "Show help",
	category = "General",
})

-- File browser
add({
	mode = "n",
	lhs = "<leader>er",
	rhs = ":Oil .<cr>",
	desc = "Open file browser in root directory",
	category = "File Browser",
})
add({
	mode = "n",
	lhs = "<leader>ed",
	rhs = ":Oil<cr>",
	desc = "Open file browser in current directory",
	category = "File Browser",
})

-- LSP
set("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>")
set("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>")
-- set("n", "gn", ":lua vim.diagnostic.goto_next()<CR>")
-- set("n", "gp", ":lua vim.diagnostic.goto_prev()<CR>")
set("n", "ge", ":lua vim.diagnostic.open_float()<CR>")
set("n", "gr", ":lua require('fzf-lua').lsp_references()<CR>")
set("n", "gd", ":lua vim.lsp.buf.definition()<CR>")
-- set("n", "gh", ":lua vim.lsp.buf.hover()<CR>")

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
add({ mode = "n", lhs = "<leader>ms", rhs = ":Messages messages<cr>", desc = "Show messages", category = "General" })
set("n", "<C-e>", "2<C-e>")
set("n", "<C-y>", "2<C-y>")
set({ "n", "i", "v" }, "<C-h>", ":vertical resize -5<CR>")
set({ "n", "i", "v" }, "<C-l>", ":vertical resize +5<CR>")
add({ mode = "n", lhs = "<leader>ci", rhs = ":Inspect<CR>", desc = "Inspect character", category = "General" })
add({ mode = "n", lhs = "<leader>sv", rhs = ":SSave default<CR>", desc = "Save session", category = "Session" })
add({ mode = "n", lhs = "<leader>sl", rhs = ":SLoad default<CR>", desc = "Load session", category = "Session" })

-- Diffview
add({
	mode = "n",
	lhs = "<leader>ds",
	rhs = ":lua require('utils').toggle_diffview_status()<CR>",
	desc = "Toggle diffview status",
	category = "Diffview",
})
add({
	mode = "n",
	lhs = "<leader>db",
	rhs = ":lua require('utils').toggle_diffview_branch()<CR>",
	desc = "Toggle diffview branch",
	category = "Diffview",
})
add({
	mode = "n",
	lhs = "<leader>dh",
	rhs = ":DiffviewFileHistory %<CR>",
	desc = "Diffview file history",
	category = "Diffview",
})

set("n", "<leader>dvfh", "<cmd>DiffviewFileHistory %<cr>")

-- ChatGPT
set("n", "<leader>cpc", ":lua require('utils').copilot_chat()<cr>")
set("n", "<leader>cpt", ":lua require('utils').copilot_chat_toggle()<cr>")
set("n", "<leader>cpe", "<cmd>Copilot enable<cr>")
set("n", "<leader>cpd", "<cmd>Copilot disable<cr>")

-- Aerial
add({ mode = "n", lhs = "<leader>ae", rhs = ":AerialToggle<cr>", desc = "Toggle Aerial", category = "Aerial" })

-- Spectre
add({
	mode = "n",
	lhs = "<leader>sr",
	rhs = ":lua require('spectre').toggle()<cr>",
	desc = "Search and replace",
	category = "Spectre",
})

-- Git
set("n", "<leader>hr", gs.reset_hunk)
set("n", "<leader>gsb", ":lua require('utils').change_git_signs_base()<cr>")

-- Oil
set("n", "<leader>dc", ":lua require('utils').get_trimmed_cwd()<cr>")
