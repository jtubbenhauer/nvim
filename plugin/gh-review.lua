-- Local plugin: loaded via pack/local/opt/ symlink, not vim.pack
vim.cmd.packadd('gh-review.nvim')

require('gh-review').setup()

local set = vim.keymap.set
set("n", "<leader>gr", "<cmd>GhReview<cr>", { desc = "GitHub PR review" })
set("n", "<leader>grc", "<cmd>GhReviewClose<cr>", { desc = "Close PR review" })
set("n", "<leader>grr", "<cmd>GhReviewRefresh<cr>", { desc = "Refresh PR review" })
