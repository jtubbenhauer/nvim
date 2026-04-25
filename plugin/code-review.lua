vim.pack.add({
  'https://github.com/jtubbenhauer/code-review.nvim',
  'https://github.com/axkirillov/unified.nvim',
})

require('unified').setup()
require('code-review').setup()

local set = vim.keymap.set
set("n", "<leader>cr", "<cmd>Review<cr>", { desc = "Start code review" })
set("n", "<leader>crl", "<cmd>ReviewLocal<cr>", { desc = "Review local changes" })
set("n", "<leader>crc", "<cmd>ReviewClose<cr>", { desc = "Close code review" })
set("n", "<leader>crr", "<cmd>ReviewRefresh<cr>", { desc = "Refresh code review" })
set("n", "<leader>crn", function() require('code-review').mark_and_next() end, { desc = "Mark reviewed & next" })
set("n", "<leader>crm", function() require('code-review').toggle_reviewed() end, { desc = "Toggle reviewed" })
set("n", "<leader>cru", function() require('code-review').next_unreviewed() end, { desc = "Next unreviewed" })
set("n", "<leader>crd", function() require('code-review').toggle_unified_diff() end, { desc = "Toggle unified diff" })
