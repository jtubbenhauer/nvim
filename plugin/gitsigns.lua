vim.pack.add({
  'https://github.com/lewis6991/gitsigns.nvim',
})

local gs = require('gitsigns')

gs.setup({
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 0,
  },
  on_attach = function(bufnr)
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map("n", "]c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        gs.nav_hunk("next")
      end
    end)

    map("n", "[c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
      else
        gs.nav_hunk("prev")
      end
    end)
  end,
})

local set = vim.keymap.set
set("n", "<leader>hr", gs.reset_hunk)
set("n", "<leader>hs", gs.stage_hunk)
set("n", "<leader>gstb", gs.toggle_current_line_blame)
set("n", "<leader>gsb", ":lua require('utils').change_git_signs_base()<cr>")
