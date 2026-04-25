local set = vim.keymap.set

-- Save
set("n", "<C-s>", "<cmd>w<cr>")
set({ "i", "v" }, "<C-s>", "<Esc><cmd>w<cr>")

-- Splits / windows
set("n", "<leader>vs", "<cmd>vs<CR><cmd>wincmd l<CR>")
set("n", "<leader>ct", "<cmd>tabclose<CR>")
set("n", "<leader>cb", "<cmd>q<cr>")

-- Scrolling
set("n", "<C-e>", "2<C-e>")
set("n", "<C-y>", "2<C-y>")

-- Resize
set({ "n", "i", "v" }, "<C-h>", ":vertical resize -5<CR>")
set({ "n", "i", "v" }, "<C-l>", ":vertical resize +5<CR>")

-- Inspect
set("n", "<leader>ci", ":Inspect<CR>")

-- Copy paths
set("n", "<leader>cd", ":lua require('utils').copy_buffer_dir()<cr>")
set("n", "<leader>cp", ":lua require('utils').copy_buffer_path()<cr>")
