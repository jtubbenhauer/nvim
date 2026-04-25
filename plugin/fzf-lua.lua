vim.pack.add({
  'https://github.com/ibhagwan/fzf-lua',
})

require('fzf-lua').setup({
  defaults = {
    formatter = "path.filename_first",
  },
  keymap = {
    fzf = {
      ["ctrl-d"] = "half-page-down",
      ["ctrl-u"] = "half-page-up",
    },
  },
  winopts = {
    preview = {
      layout = "horizontal",
      horizontal = "right:40%",
    },
    height = 0.90,
    width = 0.85,
  },
  grep = {
    rg_glob = true,
    glob_flag = "--iglob",
    glob_separator = "%s%-%-",
  },
})

local set = vim.keymap.set
set("n", "<leader>fz", ":lua require('fzf-lua').builtin({ winopts = { fullscreen=false, height=0.8, width=0.5 } })<cr>")
set("n", "<leader>sf", ":lua require('fzf-lua').files()<cr>")
set("n", "<leader>sw", ":lua require('fzf-lua').grep_cword()<cr>")
set("n", "<leader>ss", ":lua require('fzf-lua').git_status()<cr>")
set("n", "<leader>sc", ":lua require('utils').fzf_git_changes()<cr>")
set("n", "<leader>qf", ":lua require('fzf-lua').quickfix()<cr>")
set("n", "<leader>sg", ":lua require('fzf-lua').live_grep()<cr>")
set("n", "<leader>so", ":lua require('fzf-lua').buffers()<cr>")
set("n", "<leader>sa", ":lua require('fzf-lua').resume()<cr>")
set("n", "<leader>sd", ":lua require('utils').fzf_dirs()<cr>")
set("n", "<leader>si", ":lua require('utils').grep_directory()<cr>")
set("n", "gr", ":lua require('fzf-lua').lsp_references()<CR>")
set("n", "gd", ":lua require('fzf-lua').lsp_definitions()<CR>")
