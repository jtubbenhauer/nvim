vim.pack.add({
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  'https://github.com/windwp/nvim-ts-autotag',
})

require('nvim-treesitter').setup()
require('nvim-ts-autotag').setup()

-- Highlighting + indentation (replaces old module system)
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    pcall(vim.treesitter.start)
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

-- Ensure parsers installed
local ensure = { 'c', 'lua', 'vim', 'vimdoc', 'query', 'javascript', 'typescript', 'html' }
local installed = require('nvim-treesitter.config').get_installed()
local to_install = vim.iter(ensure):filter(function(p)
  return not vim.tbl_contains(installed, p)
end):totable()
if #to_install > 0 then
  require('nvim-treesitter').install(to_install)
end
