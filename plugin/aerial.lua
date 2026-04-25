vim.pack.add({
  'https://github.com/stevearc/aerial.nvim',
})

require('aerial').setup({
  layout = { min_width = 15 },
})

vim.keymap.set("n", "<leader>ae", ":AerialToggle<cr>")
