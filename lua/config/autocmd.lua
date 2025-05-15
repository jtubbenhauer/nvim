vim.cmd([[
augroup highlight_yank
autocmd!
au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
augroup END
]])

vim.api.nvim_create_user_command("VS", function(opts)
	vim.cmd("vert rightb " .. opts.args)
end, { nargs = 1 })

vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		-- FormatDisable! will disable formatting just for this buffer
		vim.b.disable_autoformat = true
	else
		vim.g.disable_autoformat = true
	end
end, {
	desc = "Disable autoformat-on-save",
	bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
end, {
	desc = "Re-enable autoformat-on-save",
})

vim.cmd([[
au WinNew * au BufEnter * ++once
  \ if (&bt ==? 'help' || &ft ==? 'man')
  \ && winwidth(winnr('#')) >= 180 | wincmd L | endif
]])

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "diffview://*",
  callback = function()
    vim.b.coc_enabled = false
  end,
})

-- cool gippity debugging
-- vim.api.nvim_create_autocmd({ "FileType", "WinEnter", "BufWinEnter" }, {
--   pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
--   callback = function(ctx)
--     -- print a debug line so you can see it firing:
--     vim.notify(string.format(
--       "autocmd[%s]: buf=%s filetype=%s diff=%s",
--       ctx.event,
--       vim.fn.bufname("%"),
--       vim.bo.filetype,
--       vim.wo.diff
--     ))
--
--     if vim.wo.diff then
--       vim.b.coc_enabled = false
--       vim.notify("→ coc disabled here")
--     end
--   end,
-- })

