vim.pack.add({
  'https://github.com/sindrets/diffview.nvim',
})

require('diffview').setup()

local set = vim.keymap.set
set("n", "<leader>ds", ":lua require('utils').toggle_diffview_status()<CR>")
set("n", "<leader>db", ":lua require('utils').toggle_diffview_branch()<CR>")
set("n", "<leader>dh", ":DiffviewFileHistory %<CR>")
set("n", "<leader>dvfh", "<cmd>DiffviewFileHistory %<cr>")
