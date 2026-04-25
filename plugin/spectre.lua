vim.pack.add({
  'https://github.com/nvim-pack/nvim-spectre',
})

vim.keymap.set("n", "<leader>sr", ":lua require('spectre').toggle()<cr>")
