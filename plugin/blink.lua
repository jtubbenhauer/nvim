vim.pack.add({
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.x') },
  'https://github.com/rafamadriz/friendly-snippets',
})

require('blink.cmp').setup({
  keymap = {
    preset = "default",
    ["<C-j>"] = { "select_next", "fallback" },
    ["<C-k>"] = { "select_prev", "fallback" },
    ["<Enter>"] = { "select_and_accept", "fallback" },
    ["<C-a>"] = { "show" },
  },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "mono",
  },
  sources = {
    default = { "lsp", "buffer" },
    providers = {
      lsp = { async = true },
    },
  },
  fuzzy = { implementation = "rust" },
  signature = { enabled = true },
  completion = {
    trigger = {
      show_on_blocked_trigger_characters = { "{", "}", " ", "\n", "\t" },
    },
  },
})
