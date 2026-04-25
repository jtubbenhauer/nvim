return {
  filetypes = { "javascript", "astro", "javascriptreact", "typescript", "typescriptreact", "htmlangular" },
  settings = {
    complete_function_calls = true,
    vtsls = {
      autoUseWorkspaceTsdk = true,
      experimental = {
        completion = {
          enableServerSideFuzzyMatch = true,
          entriesLimit = 20,
        },
      },
    },
    typescript = {
      tsserver = {
        maxTsServerMemory = 16000,
      },
    },
  },
}
