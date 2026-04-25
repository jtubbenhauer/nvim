vim.pack.add({
  'https://github.com/stevearc/dressing.nvim',
})

require('dressing').setup({
  select = {
    backend = { "fzf_lua" },
    fzf_lua = {
      winopts = {
        fullscreen = false,
        height = 0.5,
        width = 0.5,
        preview = { hidden = "hidden" },
      },
    },
  },
})
