vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/projekt0n/github-nvim-theme',
  'https://github.com/calind/selenized.nvim',
  'https://github.com/Shatur/neovim-ayu',
  'https://github.com/RostislavArts/naysayer.nvim',
})

require('github-theme').setup({
  options = { hide_nc_statusline = false },
  groups = {
    github_dark_default = {
      CursorLine = { bg = "#272b30" },
      FloatBorder = { fg = "#d9d9d9" },
    },
  },
})

vim.cmd('colorscheme github_dark_default')
