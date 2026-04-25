return {
  filetypes = { "typescript", "html", "htmlangular" },
  on_init = function(client)
    client.server_capabilities.renameProvider = false
  end,
}
