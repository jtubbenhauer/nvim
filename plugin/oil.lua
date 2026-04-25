vim.pack.add({
  'https://github.com/stevearc/oil.nvim',
})

require('oil').setup({
  lsp_file_methods = {
    autosave_changes = true,
  },
  view_options = {
    show_hidden = true,
  },
})

local set = vim.keymap.set
set("n", "<leader>er", ":Oil .<cr>")
set("n", "<leader>ed", ":Oil<cr>")
set("n", "<leader>dc", ":lua require('utils').get_trimmed_cwd()<cr>")
