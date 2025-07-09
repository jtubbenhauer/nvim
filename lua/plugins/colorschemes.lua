local M = {
	-- {
	-- 	"zenbones-theme/zenbones.nvim",
	-- 	-- Optionally install Lush. Allows for more configuration or extending the colorscheme
	-- 	-- If you don't want to install lush, make sure to set g:zenbones_compat = 1
	-- 	-- In Vim, compat mode is turned on as Lush only works in Neovim.
	-- 	dependencies = "rktjmp/lush.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	-- you can set set configuration options here
	-- 	-- config = function()
	-- 	--     vim.g.zenbones_darken_comments = 45
	-- 	--     vim.cmd.colorscheme('zenbones')
	-- 	--   hjhk
	-- 	-- end
	-- 	config = function()
	-- 		vim.g.zenbones_darkness = "stark"
	-- 		vim.g.zenbones_lightness = "bright"
	-- 	end,
	-- },

	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("github-theme").setup({
				options = {
					hide_nc_statusline = false,
				},
				groups = {
					github_dark_default = {
						CursorLine = { bg = "#272b30" },
						FloatBorder = { fg = "#d9d9d9" },
					},
				},
			})

			vim.cmd("colorscheme github_dark_default")
		end,
	},

	-- {
	-- 	"RRethy/base16-nvim",
	-- 	-- config = function()
	-- 	-- 	require("base16-colorscheme").setup({
	-- 	--
	-- 	-- 		-- backgrounds & shadows
	-- 	-- 		base00 = "#002b36", -- Solarized dark
	-- 	-- 		base01 = "#04242d",
	-- 	-- 		base02 = "#053047",
	-- 	-- 		base03 = "#d0d0d0", -- comments & invisibles
	-- 	--
	-- 	-- 		-- foregrounds
	-- 	-- 		base04 = "#839496", -- subtle text (unused mostly)
	-- 	-- 		base05 = "#e0e0e0", -- main text
	-- 	-- 		base06 = "#f0f0f0",
	-- 	-- 		base07 = "#ffffff", -- pure white
	-- 	--
	-- 	-- 		-- accents
	-- 	-- 		base08 = "#ff875f", -- orange (strings, errors)
	-- 	-- 		base09 = "#ffaf5f", -- light orange (numbers, built-ins)
	-- 	-- 		base0A = "#ffffff", -- white (unused)
	-- 	-- 		base0B = "#f8f8f8", -- near-white (unused)
	-- 	-- 		base0C = "#8be9fd", -- cyan (types & generics)
	-- 	-- 		base0D = "#82aaff", -- blue (keywords: export, interface, enum)
	-- 	-- 		base0E = "#ffffff", -- punctuation: :, ;, <, >, ?, =, etc.
	-- 	-- 		base0F = "#bd93f9", -- lavender (classes, tags, decorators)
	-- 	-- 	})
	-- 	-- end,
	-- },
	{ "calind/selenized.nvim" },
	-- {
	-- 	"jtubbenhauer/minimalgreen.nvim",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd.colorscheme("minimalgreen")
	-- 	end,
	-- },
	{
		"Shatur/neovim-ayu",
		config = function()
			-- require("ayu").colorscheme()
		end,
	},

	{
		"RostislavArts/naysayer.nvim",
		priority = 1000,
		lazy = false,
		-- config = function()
		-- 	vim.cmd.colorscheme("naysayer")
		-- end,
	},
}

return M
