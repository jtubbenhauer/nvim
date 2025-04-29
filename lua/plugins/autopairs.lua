local M = {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
  config = function ()
    require('nvim-autopairs').setup({
      map_cr = false
    })
  end
}

return M
