vim.pack.add({
  'https://github.com/stevearc/conform.nvim',
})

require('conform').setup({
  formatters_by_ft = {
    asm = { "asmfmt" },
    lua = { "stylua" },
    astro = { "prettier" },
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    typescriptreact = { "prettier" },
    markdown = { "prettierd" },
    html = { "prettierd" },
    elixir = { "mix" },
    eelixir = { "mix" },
    heex = { "mix" },
    surface = { "mix" },
    htmlangular = { "prettierd" },
    css = { "prettierd" },
    scss = { "prettierd" },
    sass = { "prettierd" },
    xml = { "xmlformatter" },
    proto = { "clang-format" },
    python = { "black" },
    go = { "golines" },
    json = { "prettierd" },
    jsonc = { "prettierd" },
    cpp = { "clang-format" },
    yaml = { "prettierd" },
    yml = { "prettierd" },
    cs = { "csharpier" },
    rust = { "rustfmt" },
    svelte = { "prettierd" },
  },
  notify_on_error = false,
  format_on_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { timeout_ms = 2000, lsp_format = "fallback" }
  end,
})

vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, { desc = "Disable autoformat-on-save", bang = true })

vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, { desc = "Re-enable autoformat-on-save" })

vim.api.nvim_create_user_command("ToggleFormatOnSave", function()
  vim.g.format_on_save = not vim.g.format_on_save
  print("Format on save " .. (vim.g.format_on_save and "enabled" or "disabled"))
end, { desc = "Toggle format on save" })

vim.keymap.set("n", "<leader>ft", ":ToggleFormatOnSave<CR>")
