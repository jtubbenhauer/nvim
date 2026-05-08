return {
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  handlers = {
    ["textDocument/diagnostic"] = function(err, result, ctx)
      if result and result.items then
        result.items = vim.tbl_filter(function(d)
          -- Filter namespace-style import "not callable" errors (TS7 vs TS5 compat)
          if d.code == 2349 then
            local related = d.relatedInformation or {}
            for _, info in ipairs(related) do
              if info.message:find("namespace%-style import") then
                return false
              end
            end
          end
          return true
        end, result.items)
      end
      return vim.lsp.diagnostic.on_diagnostic(err, result, ctx)
    end,
  },
}
