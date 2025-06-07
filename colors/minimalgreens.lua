-- Minimal Green Monochrome Color Scheme

local M = {}

-- Color palette - only greens, white, and background
local colors = {
	-- Base colors
	bg = "#062421",
	fg = "#ffffff",

	-- Green shades
	medium_green = "#44aa88", -- Medium green for comments
	dark_green = "#336655", -- Darker green for line numbers
	pale_green = "#99ffcc", -- Pale green for types/identifiers
	light_green = "#00ff88", -- Bright green for strings

	-- UI colors
	selection = "#1a4a42", -- Slightly lighter than bg for selections
	cursor_line = "#0a332e", -- Current line highlight
	visual = "#2a5a52", -- Visual selection
	search = "#44ff99", -- Search highlights (bright green)
	error = "#ff6666", -- Keep error readable but muted
	warning = "#ffaa66", -- Keep warning readable but muted
}

local function set_highlights()
	local highlights = {
		-- Editor highlights
		Normal = { fg = colors.fg, bg = colors.bg },
		NormalFloat = { fg = colors.fg, bg = colors.selection },
		FloatBorder = { fg = colors.pale_green, bg = colors.selection },

		LineNr = { fg = colors.dark_green },
		CursorLine = { bg = colors.cursor_line },
		CursorLineNr = { fg = colors.light_green, bold = true },
		Visual = { bg = colors.visual },
		Search = { fg = colors.bg, bg = colors.search },
		IncSearch = { fg = colors.bg, bg = colors.light_green },

		-- Status line
		StatusLine = { fg = colors.fg, bg = colors.selection },
		StatusLineNC = { fg = colors.medium_green, bg = colors.selection },

		-- Syntax highlighting - minimal with strategic bolding
		Comment = { fg = colors.medium_green, italic = false },
		Constant = { fg = colors.pale_green },
		String = { fg = colors.light_green },
		Character = { fg = colors.light_green },
		Number = { fg = colors.pale_green },
		Boolean = { fg = colors.pale_green },
		Float = { fg = colors.pale_green },

		Identifier = { fg = colors.fg }, -- Variables stay white
		Function = { fg = colors.pale_green },

		-- Keywords get bold treatment
		Statement = { fg = colors.fg, bold = true },
		Conditional = { fg = colors.fg, bold = true },
		Repeat = { fg = colors.fg, bold = true },
		Label = { fg = colors.fg, bold = true },
		Operator = { fg = colors.fg },
		Keyword = { fg = colors.fg, bold = true },
		Exception = { fg = colors.fg, bold = true },

		PreProc = { fg = colors.fg, bold = true },
		Include = { fg = colors.fg, bold = true },
		Define = { fg = colors.fg, bold = true },
		Macro = { fg = colors.fg, bold = true },
		PreCondit = { fg = colors.fg, bold = true },

		-- Types and interfaces stay normal weight
		Type = { fg = colors.pale_green },
		StorageClass = { fg = colors.pale_green },
		Structure = { fg = colors.pale_green },
		Typedef = { fg = colors.pale_green },

		Special = { fg = colors.light_green },
		SpecialChar = { fg = colors.light_green },
		Tag = { fg = colors.pale_green },
		Delimiter = { fg = colors.fg },
		SpecialComment = { fg = colors.light_green },
		Debug = { fg = colors.medium_green },

		-- Errors and diagnostics (keep readable)
		Error = { fg = colors.error },
		ErrorMsg = { fg = colors.error },
		WarningMsg = { fg = colors.warning },

		-- Popup menu
		Pmenu = { fg = colors.fg, bg = colors.selection },
		PmenuSel = { fg = colors.bg, bg = colors.light_green },
		PmenuSbar = { bg = colors.selection },
		PmenuThumb = { bg = colors.light_green },

		-- Tabs
		TabLine = { fg = colors.medium_green, bg = colors.selection },
		TabLineFill = { bg = colors.selection },
		TabLineSel = { fg = colors.fg, bg = colors.bg },

		-- Splits
		VertSplit = { fg = colors.selection },
		WinSeparator = { fg = colors.selection },

		-- Git signs (if using gitsigns.nvim)
		GitSignsAdd = { fg = colors.light_green },
		GitSignsChange = { fg = colors.pale_green },
		GitSignsDelete = { fg = colors.medium_green },
		GitSignsCurrentLineBlame = { fg = colors.medium_green },

		-- LSP diagnostics
		DiagnosticError = { fg = colors.error },
		DiagnosticWarn = { fg = colors.warning },
		DiagnosticInfo = { fg = colors.pale_green },
		DiagnosticHint = { fg = colors.medium_green },

		-- Treesitter highlights (modern syntax highlighting)
		["@variable"] = { fg = colors.fg }, -- Variables stay white
		["@variable.builtin"] = { fg = colors.pale_green },
		["@function"] = { fg = colors.pale_green },
		["@function.builtin"] = { fg = colors.pale_green },
		["@keyword"] = { fg = colors.fg, bold = true }, -- Keywords bold
		["@keyword.function"] = { fg = colors.fg, bold = true },
		["@keyword.operator"] = { fg = colors.fg, bold = true },
		["@keyword.return"] = { fg = colors.fg, bold = true },
		["@string"] = { fg = colors.light_green },
		["@number"] = { fg = colors.pale_green },
		["@boolean"] = { fg = colors.pale_green },
		["@type"] = { fg = colors.pale_green }, -- Types not bold
		["@type.builtin"] = { fg = colors.pale_green },
		["@comment"] = { fg = colors.medium_green, italic = false },
		["@operator"] = { fg = colors.fg },
		["@punctuation"] = { fg = colors.fg },
		["@punctuation.bracket"] = { fg = colors.fg },
		["@punctuation.delimiter"] = { fg = colors.fg },
		["@tag"] = { fg = colors.pale_green },
		["@attribute"] = { fg = colors.light_green },
		["@property"] = { fg = colors.fg }, -- Object properties stay white
		["@field"] = { fg = colors.fg }, -- Struct fields stay white
		["@parameter"] = { fg = colors.fg }, -- Function parameters stay white
		["@constant"] = { fg = colors.pale_green },
		["@constant.builtin"] = { fg = colors.pale_green },
		["@constructor"] = { fg = colors.pale_green },
		["@namespace"] = { fg = colors.pale_green },
		["@module"] = { fg = colors.pale_green },
	}

	-- Apply all highlights
	for group, opts in pairs(highlights) do
		vim.api.nvim_set_hl(0, group, opts)
	end
end

-- Main function to load the colorscheme
function M.load()
	-- Reset existing highlights
	vim.cmd("highlight clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end

	-- Set colorscheme name
	vim.g.colors_name = "minimalgreen"

	-- Apply highlights
	set_highlights()
end

-- Auto-load if this file is sourced directly
M.load()

return M
