vim.pack.add({
  'https://github.com/nvimtools/none-ls.nvim',
  'https://github.com/nvimtools/none-ls-extras.nvim',
})

local eslint_d_filetypes = {
  "htmlangular",
  "html",
  "typescript",
  "typescriptreact",
  "javascript",
  "javascriptreact",
  "astro",
}

require('null-ls').setup({
  sources = {
    require('none-ls.code_actions.eslint_d').with({
      filetypes = eslint_d_filetypes,
    }),
    require('none-ls.diagnostics.eslint_d').with({
      filetypes = eslint_d_filetypes,
    }),
  },
})
