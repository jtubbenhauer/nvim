vim.pack.add({
  'https://github.com/github/copilot.vim',
})

vim.cmd("Copilot disable")

local set = vim.keymap.set
set("n", "<leader>cpe", "<cmd>Copilot enable<cr>")
set("n", "<leader>cpd", "<cmd>Copilot disable<cr>")
