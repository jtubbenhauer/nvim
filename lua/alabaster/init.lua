-- Alabaster color theme for Neovim
-- Based on principles from tonsky.me/blog/syntax-highlighting/
-- Faithful port of tonsky/sublime-scheme-alabaster palette.
--
-- Philosophy (per article):
--   - Highlight ONLY: strings, constants, comments, top-level definitions
--   - Keywords/variables/function calls stay base foreground color
--   - Punctuation greyed (not invisible, just stepped back)
--   - Comments highlighted bright, NOT dimmed (good comments deserve attention)
--   - Fn defs brighter than var defs (article's final nesting tweak)
--   - No bold, no italic (scanner can't rely on typography variance)
--   - Minimum colors a person can memorize

local M = {}

-- ---------------------------------------------------------------------------
-- Palettes
-- ---------------------------------------------------------------------------

local palettes = {
  light = {
    -- Core chrome
    bg          = "#F7F7F7",
    fg          = "#000000",
    line_hl     = "#F0F0F0",
    selection   = "#BFDBFE",
    inactive_sel= "#E0E0E0",
    cursor_line = "#F0F0F0",
    cursor      = "#007ACC",  -- caret / active accent
    find_hl     = "#FFBC5D",  -- search / find highlight

    -- Semantic four
    string      = "#448C27",  -- green
    constant    = "#7A3E9D",  -- magenta / purple
    comment     = "#AA3731",  -- red   (light: red comments; dark frees red for errors)
    def_var     = "#325CC0",  -- blue  (variable / type definitions)
    def_fn      = "#B8860B",  -- amber (function defs brighter per article final tweak)
                              -- #FFBC5D too pale on #F7F7F7; dark goldenrod reads cleanly

    -- Support
    punct       = "#777777",  -- grey punctuation / delimiters
    escape      = "#777777",  -- escape sequences, placeholders

    -- UI accent
    error       = "#AA3731",
    warn        = "#B8860B",
    info        = "#325CC0",
    hint        = "#7A3E9D",

    -- Diff / git
    diff_add    = "#448C27",
    diff_del    = "#AA3731",
    diff_change = "#B8860B",
    diff_text   = "#325CC0",

    -- Borders / chrome
    border      = "#D0D0D0",
    menu_bg     = "#EEEEEE",
    menu_sel    = "#BFDBFE",
    statusline  = "#E0E0E0",
    statusline_fg = "#444444",
    lnum        = "#AAAAAA",
    lnum_cur    = "#555555",
    fold        = "#BBBBBB",
    nontext     = "#CCCCCC",
    winsep      = "#D0D0D0",
    indent      = "#E0E0E0",
  },

  dark = {
    -- Core chrome — true near-black, no tint
    bg          = "#090B10",
    fg          = "#D4D4D4",
    line_hl     = "#0F1219",
    selection   = "#1E2A45",
    inactive_sel= "#141A2E",
    cursor_line = "#0F1219",
    cursor      = "#E5A045",  -- caret / active accent
    find_hl     = "#E5A045",  -- search / find highlight

    -- Semantic four — vivid, not muted
    string      = "#98C379",  -- bright green  (VS Code-ish, punchy)
    constant    = "#C678DD",  -- bright purple
    comment     = "#E5C07B",  -- bright yellow
    def_var     = "#61AFEF",  -- bright blue
    def_fn      = "#E5A045",  -- bright amber

    -- Support
    punct       = "#5A6A7A",  -- grey-blue, stepped back
    escape      = "#5A6A7A",

    -- UI accent
    error       = "#E06C75",  -- bright red
    warn        = "#E5A045",
    info        = "#61AFEF",
    hint        = "#C678DD",

    -- Diff / git
    diff_add    = "#98C379",
    diff_del    = "#E06C75",
    diff_change = "#E5A045",
    diff_text   = "#61AFEF",

    -- Borders / chrome
    border      = "#1C2130",
    menu_bg     = "#060810",
    menu_sel    = "#1E2A45",
    statusline  = "#060810",
    statusline_fg = "#8A8A9A",
    lnum        = "#2E3444",
    lnum_cur    = "#5A6A7A",
    fold        = "#2E3444",
    nontext     = "#1C2130",
    winsep      = "#1C2130",
    indent      = "#0D1018",
  },
}

-- ---------------------------------------------------------------------------
-- Highlight table builder
-- ---------------------------------------------------------------------------

--- Build the full highlight spec table for a given variant.
--- Returns a list of { group, spec } pairs where spec is passed to nvim_set_hl.
---@param p table palette
local function build_highlights(p)
  -- Convenience: transparent bg for floating windows reuses editor bg
  local hl = {}

  local function hi(group, spec)
    hl[#hl + 1] = { group, spec }
  end

  -- -------------------------------------------------------------------------
  -- Editor chrome
  -- -------------------------------------------------------------------------
  hi("Normal",          { fg = p.fg,          bg = p.bg })
  hi("NormalNC",        { fg = p.fg,          bg = p.bg })
  hi("NormalFloat",     { fg = p.fg,          bg = p.menu_bg })
  hi("FloatBorder",     { fg = p.border,      bg = p.menu_bg })
  hi("FloatTitle",      { fg = p.def_var,     bg = p.menu_bg })

  hi("CursorLine",      { bg = p.cursor_line })
  hi("CursorColumn",    { bg = p.cursor_line })
  hi("ColorColumn",     { bg = p.cursor_line })
  hi("Cursor",          { fg = p.bg,          bg = p.cursor })
  hi("lCursor",         { fg = p.bg,          bg = p.cursor })
  hi("CursorIM",        { fg = p.bg,          bg = p.cursor })

  hi("Visual",          { bg = p.selection })
  hi("VisualNOS",       { bg = p.inactive_sel })

  hi("LineNr",          { fg = p.lnum })
  hi("CursorLineNr",    { fg = p.lnum_cur })
  hi("SignColumn",      { fg = p.lnum,        bg = p.bg })
  hi("FoldColumn",      { fg = p.fold,        bg = p.bg })
  hi("Folded",          { fg = p.punct,       bg = p.menu_bg })

  hi("StatusLine",      { fg = p.statusline_fg, bg = p.statusline })
  hi("StatusLineNC",    { fg = p.lnum,          bg = p.statusline })
  hi("WinSeparator",    { fg = p.winsep })
  hi("VertSplit",       { fg = p.winsep })

  hi("TabLine",         { fg = p.statusline_fg, bg = p.statusline })
  hi("TabLineSel",      { fg = p.fg,            bg = p.bg })
  hi("TabLineFill",     { fg = p.statusline_fg, bg = p.statusline })

  hi("Pmenu",           { fg = p.fg,          bg = p.menu_bg })
  hi("PmenuSel",        { fg = p.fg,          bg = p.menu_sel })
  hi("PmenuSbar",       { bg = p.menu_bg })
  hi("PmenuThumb",      { bg = p.border })
  hi("PmenuKind",       { fg = p.def_var,     bg = p.menu_bg })
  hi("PmenuKindSel",    { fg = p.def_var,     bg = p.menu_sel })
  hi("PmenuExtra",      { fg = p.punct,       bg = p.menu_bg })
  hi("PmenuExtraSel",   { fg = p.punct,       bg = p.menu_sel })

  hi("Search",          { fg = p.bg,          bg = p.find_hl })
  hi("IncSearch",       { fg = p.bg,          bg = p.find_hl })
  hi("CurSearch",       { fg = p.bg,          bg = p.find_hl })
  hi("Substitute",      { fg = p.bg,          bg = p.find_hl })

  hi("MatchParen",      { fg = p.cursor,      bg = p.selection })

  hi("NonText",         { fg = p.nontext })
  hi("Whitespace",      { fg = p.indent })
  hi("SpecialKey",      { fg = p.punct })
  hi("EndOfBuffer",     { fg = p.nontext })
  hi("WildMenu",        { fg = p.fg,          bg = p.menu_sel })

  hi("Title",           { fg = p.def_fn })
  hi("Question",        { fg = p.info })
  hi("MoreMsg",         { fg = p.info })
  hi("ModeMsg",         { fg = p.fg })
  hi("ErrorMsg",        { fg = p.error })
  hi("WarningMsg",      { fg = p.warn })

  hi("Directory",       { fg = p.def_var })
  hi("QuickFixLine",    { bg = p.selection })
  hi("Conceal",         { fg = p.punct })

  hi("SpellBad",        { sp = p.error,   undercurl = true })
  hi("SpellCap",        { sp = p.warn,    undercurl = true })
  hi("SpellRare",       { sp = p.hint,    undercurl = true })
  hi("SpellLocal",      { sp = p.info,    undercurl = true })

  -- -------------------------------------------------------------------------
  -- Syntax (legacy groups — fallback when treesitter unavailable)
  -- The four rules:
  --   String  → string color
  --   Constant → constant color (covers Number, Boolean, Float, Character)
  --   Comment → comment color (BRIGHT, not dimmed)
  --   Identifier/Function → def_fn for definitions
  --   Keywords → base fg (NOT colored)
  --   Punctuation → greyed
  -- -------------------------------------------------------------------------
  hi("Comment",         { fg = p.comment })
  hi("String",          { fg = p.string })
  hi("Character",       { fg = p.constant })
  hi("Number",          { fg = p.constant })
  hi("Float",           { fg = p.constant })
  hi("Boolean",         { fg = p.constant })
  hi("Constant",        { fg = p.constant })
  hi("SpecialChar",     { fg = p.escape })

  -- Definitions: types, functions, identifiers at definition site
  hi("Identifier",      { fg = p.fg })        -- generic usage → base (could be anywhere)
  hi("Function",        { fg = p.def_fn })     -- function names at definition
  hi("Type",            { fg = p.def_var })    -- type names
  hi("TypeDef",         { fg = p.def_var })
  hi("StorageClass",    { fg = p.fg })         -- static, const qualifiers → base
  hi("Structure",       { fg = p.def_var })
  hi("Typedef",         { fg = p.def_var })

  -- Keywords → base fg (per article: "don't highlight language keywords")
  hi("Statement",       { fg = p.fg })
  hi("Keyword",         { fg = p.fg })
  hi("Conditional",     { fg = p.fg })
  hi("Repeat",          { fg = p.fg })
  hi("Label",           { fg = p.fg })
  hi("Operator",        { fg = p.punct })      -- operators slightly grey like punctuation
  hi("Exception",       { fg = p.fg })
  hi("PreProc",         { fg = p.fg })
  hi("Include",         { fg = p.fg })
  hi("Define",          { fg = p.fg })
  hi("Macro",           { fg = p.fg })
  hi("PreCondit",       { fg = p.fg })

  hi("Special",         { fg = p.punct })
  hi("SpecialComment",  { fg = p.comment })
  hi("Debug",           { fg = p.warn })
  hi("Delimiter",       { fg = p.punct })
  hi("Tag",             { fg = p.def_var })

  hi("Underlined",      { underline = true })
  hi("Ignore",          { fg = p.nontext })
  hi("Error",           { fg = p.error })
  hi("Todo",            { fg = p.comment })    -- TODO/FIXME in comments → comment color

  -- -------------------------------------------------------------------------
  -- Treesitter semantic groups (@-prefixed)
  -- Follows nvim-treesitter capture naming as of v0.9+
  -- -------------------------------------------------------------------------

  -- Variables and identifiers — base fg (no color; they're everywhere)
  hi("@variable",               { fg = p.fg })
  hi("@variable.builtin",       { fg = p.fg })   -- self, this, etc.
  hi("@variable.parameter",     { fg = p.fg })
  hi("@variable.member",        { fg = p.fg })

  -- Constants — colored (they're reference points, per article)
  hi("@constant",               { fg = p.constant })
  hi("@constant.builtin",       { fg = p.constant })
  hi("@constant.macro",         { fg = p.constant })
  hi("@number",                 { fg = p.constant })
  hi("@number.float",           { fg = p.constant })
  hi("@boolean",                { fg = p.constant })

  -- Strings — colored
  hi("@string",                 { fg = p.string })
  hi("@string.regex",           { fg = p.string })
  hi("@string.regexp",          { fg = p.string })
  hi("@string.escape",          { fg = p.escape })
  hi("@string.special",         { fg = p.escape })
  hi("@string.special.symbol",  { fg = p.constant })  -- symbols/atoms (Ruby, Elixir, etc.)
  hi("@string.special.url",     { fg = p.def_var, underline = true })
  hi("@character",              { fg = p.constant })
  hi("@character.special",      { fg = p.escape })

  -- Comments — BRIGHT, not hidden (article's most controversial rule)
  hi("@comment",                { fg = p.comment })
  hi("@comment.documentation",  { fg = p.comment })
  -- Disabled / commented-out code: still comment color but muted via punct
  -- (most languages can't distinguish, so keep uniform)

  -- Functions and methods — base fg for CALLS; def_fn for DEFINITIONS
  hi("@function",               { fg = p.def_fn })   -- definition
  hi("@function.builtin",       { fg = p.fg })        -- builtin calls (print, len…) → base
  hi("@function.call",          { fg = p.fg })        -- call sites → base (per article: calls everywhere)
  hi("@function.macro",         { fg = p.fg })
  hi("@function.method",        { fg = p.def_fn })    -- method definition
  hi("@function.method.call",   { fg = p.fg })        -- method call sites → base
  hi("@constructor",            { fg = p.def_fn })

  -- Types — def_var (var-level definitions, structurally blue)
  hi("@type",                   { fg = p.def_var })
  hi("@type.builtin",           { fg = p.def_var })
  hi("@type.definition",        { fg = p.def_var })
  hi("@type.qualifier",         { fg = p.fg })        -- const, static, etc. → base

  -- Namespaces / modules
  hi("@module",                 { fg = p.fg })
  hi("@module.builtin",         { fg = p.fg })
  hi("@namespace",              { fg = p.fg })

  -- Keywords — base fg
  hi("@keyword",                { fg = p.fg })
  hi("@keyword.function",       { fg = p.fg })
  hi("@keyword.operator",       { fg = p.punct })
  hi("@keyword.import",         { fg = p.fg })
  hi("@keyword.storage",        { fg = p.fg })
  hi("@keyword.repeat",         { fg = p.fg })
  hi("@keyword.return",         { fg = p.fg })
  hi("@keyword.debug",          { fg = p.fg })
  hi("@keyword.exception",      { fg = p.fg })
  hi("@keyword.conditional",    { fg = p.fg })
  hi("@keyword.conditional.ternary", { fg = p.punct })
  hi("@keyword.directive",      { fg = p.fg })
  hi("@keyword.directive.define", { fg = p.fg })

  -- Operators and punctuation — greyed (step back, names are important)
  hi("@operator",               { fg = p.punct })
  hi("@punctuation",            { fg = p.punct })
  hi("@punctuation.bracket",    { fg = p.punct })
  hi("@punctuation.delimiter",  { fg = p.punct })
  hi("@punctuation.special",    { fg = p.punct })

  -- Properties / attributes
  hi("@property",               { fg = p.fg })
  hi("@attribute",              { fg = p.constant })
  hi("@attribute.builtin",      { fg = p.constant })

  -- Labels
  hi("@label",                  { fg = p.fg })

  -- Markup (Markdown, RST, etc.)
  hi("@markup.heading",         { fg = p.def_fn })
  hi("@markup.heading.1",       { fg = p.def_fn })
  hi("@markup.heading.2",       { fg = p.def_fn })
  hi("@markup.heading.3",       { fg = p.def_fn })
  hi("@markup.heading.4",       { fg = p.def_var })
  hi("@markup.heading.5",       { fg = p.def_var })
  hi("@markup.heading.6",       { fg = p.def_var })
  hi("@markup.bold",            { fg = p.fg })
  hi("@markup.italic",          { fg = p.fg })
  hi("@markup.strikethrough",   { fg = p.punct,   strikethrough = true })
  hi("@markup.underline",       { underline = true })
  hi("@markup.quote",           { fg = p.comment })
  hi("@markup.math",            { fg = p.constant })
  hi("@markup.link",            { fg = p.def_var,  underline = true })
  hi("@markup.link.label",      { fg = p.def_var })
  hi("@markup.link.url",        { fg = p.string,   underline = true })
  hi("@markup.raw",             { fg = p.string })
  hi("@markup.raw.block",       { fg = p.string })
  hi("@markup.list",            { fg = p.punct })
  hi("@markup.list.checked",    { fg = p.string })
  hi("@markup.list.unchecked",  { fg = p.punct })

  -- Tags (HTML/JSX)
  hi("@tag",                    { fg = p.def_var })
  hi("@tag.attribute",          { fg = p.fg })
  hi("@tag.delimiter",          { fg = p.punct })
  hi("@tag.builtin",            { fg = p.def_var })

  -- LSP semantic tokens (nvim 0.9+)
  hi("@lsp.type.class",         { fg = p.def_var })
  hi("@lsp.type.comment",       { fg = p.comment })
  hi("@lsp.type.decorator",     { fg = p.constant })
  hi("@lsp.type.enum",          { fg = p.def_var })
  hi("@lsp.type.enumMember",    { fg = p.constant })
  hi("@lsp.type.event",         { fg = p.def_var })
  hi("@lsp.type.function",      { fg = p.def_fn })
  hi("@lsp.type.interface",     { fg = p.def_var })
  hi("@lsp.type.keyword",       { fg = p.fg })
  hi("@lsp.type.macro",         { fg = p.fg })
  hi("@lsp.type.method",        { fg = p.def_fn })
  hi("@lsp.type.modifier",      { fg = p.fg })
  hi("@lsp.type.namespace",     { fg = p.fg })
  hi("@lsp.type.number",        { fg = p.constant })
  hi("@lsp.type.operator",      { fg = p.punct })
  hi("@lsp.type.parameter",     { fg = p.fg })
  hi("@lsp.type.property",      { fg = p.fg })
  hi("@lsp.type.regexp",        { fg = p.string })
  hi("@lsp.type.string",        { fg = p.string })
  hi("@lsp.type.struct",        { fg = p.def_var })
  hi("@lsp.type.type",          { fg = p.def_var })
  hi("@lsp.type.typeParameter", { fg = p.def_var })
  hi("@lsp.type.variable",      { fg = p.fg })

  -- LSP semantic modifiers (these OVERRIDE base type colors)
  hi("@lsp.mod.declaration",    { fg = p.def_fn })
  hi("@lsp.mod.definition",     { fg = p.def_fn })
  hi("@lsp.mod.readonly",       { fg = p.constant })
  hi("@lsp.mod.static",         { fg = p.fg })
  hi("@lsp.mod.deprecated",     { fg = p.punct,   strikethrough = true })
  hi("@lsp.mod.abstract",       { fg = p.def_var })
  hi("@lsp.mod.async",          { fg = p.fg })
  hi("@lsp.mod.modification",   { fg = p.fg })
  hi("@lsp.mod.documentation",  { fg = p.comment })

  -- Combine: variable at declaration site → def_var (per article)
  hi("@lsp.typemod.variable.declaration",       { fg = p.def_var })
  hi("@lsp.typemod.variable.definition",        { fg = p.def_var })
  hi("@lsp.typemod.parameter.declaration",      { fg = p.def_var })
  hi("@lsp.typemod.property.declaration",       { fg = p.def_var })

  -- -------------------------------------------------------------------------
  -- Diagnostics
  -- -------------------------------------------------------------------------
  hi("DiagnosticError",         { fg = p.error })
  hi("DiagnosticWarn",          { fg = p.warn })
  hi("DiagnosticInfo",          { fg = p.info })
  hi("DiagnosticHint",          { fg = p.hint })
  hi("DiagnosticOk",            { fg = p.string })

  hi("DiagnosticUnderlineError",{ sp = p.error,  undercurl = true })
  hi("DiagnosticUnderlineWarn", { sp = p.warn,   undercurl = true })
  hi("DiagnosticUnderlineInfo", { sp = p.info,   undercurl = true })
  hi("DiagnosticUnderlineHint", { sp = p.hint,   undercurl = true })
  hi("DiagnosticUnderlineOk",   { sp = p.string, underline = true })

  hi("DiagnosticVirtualTextError", { fg = p.error })
  hi("DiagnosticVirtualTextWarn",  { fg = p.warn })
  hi("DiagnosticVirtualTextInfo",  { fg = p.info })
  hi("DiagnosticVirtualTextHint",  { fg = p.hint })

  hi("DiagnosticSignError",     { fg = p.error, bg = p.bg })
  hi("DiagnosticSignWarn",      { fg = p.warn,  bg = p.bg })
  hi("DiagnosticSignInfo",      { fg = p.info,  bg = p.bg })
  hi("DiagnosticSignHint",      { fg = p.hint,  bg = p.bg })

  hi("DiagnosticFloatingError", { fg = p.error })
  hi("DiagnosticFloatingWarn",  { fg = p.warn })
  hi("DiagnosticFloatingInfo",  { fg = p.info })
  hi("DiagnosticFloatingHint",  { fg = p.hint })

  -- -------------------------------------------------------------------------
  -- Git / diff
  -- -------------------------------------------------------------------------
  hi("DiffAdd",     { fg = p.diff_add,    bg = p.bg })
  hi("DiffDelete",  { fg = p.diff_del,    bg = p.bg })
  hi("DiffChange",  { fg = p.diff_change, bg = p.bg })
  hi("DiffText",    { fg = p.diff_text,   bg = p.selection })

  -- gitsigns.nvim
  hi("GitSignsAdd",          { fg = p.diff_add,    bg = p.bg })
  hi("GitSignsChange",       { fg = p.diff_change, bg = p.bg })
  hi("GitSignsDelete",       { fg = p.diff_del,    bg = p.bg })
  hi("GitSignsAddNr",        { fg = p.diff_add })
  hi("GitSignsChangeNr",     { fg = p.diff_change })
  hi("GitSignsDeleteNr",     { fg = p.diff_del })
  hi("GitSignsAddLn",        { bg = p.bg })
  hi("GitSignsChangeLn",     { bg = p.bg })
  hi("GitSignsDeleteLn",     { bg = p.bg })
  hi("GitSignsCurrentLineBlame", { fg = p.punct })

  -- -------------------------------------------------------------------------
  -- Telescope / fzf-lua (common highlight groups)
  -- -------------------------------------------------------------------------
  hi("TelescopeNormal",        { fg = p.fg,        bg = p.menu_bg })
  hi("TelescopeBorder",        { fg = p.border,    bg = p.menu_bg })
  hi("TelescopePromptNormal",  { fg = p.fg,        bg = p.menu_bg })
  hi("TelescopePromptBorder",  { fg = p.border,    bg = p.menu_bg })
  hi("TelescopePromptTitle",   { fg = p.def_fn })
  hi("TelescopePreviewTitle",  { fg = p.def_var })
  hi("TelescopeResultsTitle",  { fg = p.punct })
  hi("TelescopeMatching",      { fg = p.find_hl })
  hi("TelescopeSelection",     { bg = p.menu_sel })

  hi("FzfLuaNormal",           { fg = p.fg,        bg = p.menu_bg })
  hi("FzfLuaBorder",           { fg = p.border,    bg = p.menu_bg })
  hi("FzfLuaTitle",            { fg = p.def_fn })
  hi("FzfLuaHeaderBind",       { fg = p.def_var })
  hi("FzfLuaHeaderText",       { fg = p.punct })

  -- -------------------------------------------------------------------------
  -- Completion (blink.cmp / nvim-cmp)
  -- -------------------------------------------------------------------------
  hi("BlinkCmpMenu",           { fg = p.fg,        bg = p.menu_bg })
  hi("BlinkCmpMenuBorder",     { fg = p.border,    bg = p.menu_bg })
  hi("BlinkCmpMenuSelection",  { bg = p.menu_sel })
  hi("BlinkCmpScrollBarThumb", { bg = p.border })
  hi("BlinkCmpScrollBarGutter",{ bg = p.menu_bg })
  hi("BlinkCmpLabel",          { fg = p.fg })
  hi("BlinkCmpLabelMatch",     { fg = p.def_fn })
  hi("BlinkCmpKind",           { fg = p.def_var })
  hi("BlinkCmpDoc",            { fg = p.fg,        bg = p.menu_bg })
  hi("BlinkCmpDocBorder",      { fg = p.border,    bg = p.menu_bg })
  hi("BlinkCmpDocSeparator",   { fg = p.border })
  hi("BlinkCmpSignatureHelpBorder", { fg = p.border, bg = p.menu_bg })
  hi("BlinkCmpSignatureHelpActiveParameter", { fg = p.def_fn })

  hi("CmpItemAbbr",            { fg = p.fg })
  hi("CmpItemAbbrMatch",       { fg = p.def_fn })
  hi("CmpItemAbbrMatchFuzzy",  { fg = p.def_fn })
  hi("CmpItemKind",            { fg = p.def_var })
  hi("CmpItemMenu",            { fg = p.punct })

  -- -------------------------------------------------------------------------
  -- Indent guides (ibl / indent-blankline)
  -- -------------------------------------------------------------------------
  hi("IblIndent",              { fg = p.indent })
  hi("IblScope",               { fg = p.punct })
  hi("IndentBlanklineChar",    { fg = p.indent })
  hi("IndentBlanklineContextChar", { fg = p.punct })

  -- -------------------------------------------------------------------------
  -- Which-key
  -- -------------------------------------------------------------------------
  hi("WhichKey",               { fg = p.def_fn })
  hi("WhichKeyGroup",          { fg = p.def_var })
  hi("WhichKeyDesc",           { fg = p.fg })
  hi("WhichKeySeparator",      { fg = p.punct })
  hi("WhichKeyFloat",          { bg = p.menu_bg })
  hi("WhichKeyBorder",         { fg = p.border })

  -- -------------------------------------------------------------------------
  -- Aerial (symbol outline)
  -- -------------------------------------------------------------------------
  hi("AerialLine",             { bg = p.selection })
  hi("AerialGuide",            { fg = p.indent })

  -- -------------------------------------------------------------------------
  -- Oil.nvim
  -- -------------------------------------------------------------------------
  hi("OilDir",                 { fg = p.def_var })
  hi("OilFile",                { fg = p.fg })
  hi("OilLink",                { fg = p.string })
  hi("OilSocket",              { fg = p.constant })
  hi("OilCreate",              { fg = p.diff_add })
  hi("OilDelete",              { fg = p.diff_del })
  hi("OilChange",              { fg = p.diff_change })
  hi("OilMove",                { fg = p.def_fn })
  hi("OilCopy",                { fg = p.def_var })

  -- -------------------------------------------------------------------------
  -- Diffview.nvim
  -- -------------------------------------------------------------------------
  hi("DiffviewFilePanelTitle",     { fg = p.def_fn })
  hi("DiffviewFilePanelCounter",   { fg = p.constant })
  hi("DiffviewFilePanelFileName",  { fg = p.fg })
  hi("DiffviewFilePanelPath",      { fg = p.punct })
  hi("DiffviewNormal",             { fg = p.fg,   bg = p.bg })
  hi("DiffviewFilePanelSelected",  { bg = p.selection })
  hi("DiffviewStatusAdded",        { fg = p.diff_add })
  hi("DiffviewStatusDeleted",      { fg = p.diff_del })
  hi("DiffviewStatusModified",     { fg = p.diff_change })
  hi("DiffviewStatusRenamed",      { fg = p.diff_change })
  hi("DiffviewStatusCopied",       { fg = p.def_var })
  hi("DiffviewStatusUntracked",    { fg = p.punct })

  -- -------------------------------------------------------------------------
  -- Mini.nvim (if ever used)
  -- -------------------------------------------------------------------------
  hi("MiniStatuslineModeNormal",  { fg = p.bg,  bg = p.def_var })
  hi("MiniStatuslineModeInsert",  { fg = p.bg,  bg = p.string })
  hi("MiniStatuslineModeVisual",  { fg = p.bg,  bg = p.constant })
  hi("MiniStatuslineModeReplace", { fg = p.bg,  bg = p.error })
  hi("MiniStatuslineModeCommand", { fg = p.bg,  bg = p.def_fn })

  return hl
end

-- ---------------------------------------------------------------------------
-- Public API
-- ---------------------------------------------------------------------------

---Apply the Alabaster colorscheme.
---@param variant "light"|"dark"
function M.load(variant)
  assert(variant == "light" or variant == "dark",
    "alabaster: variant must be 'light' or 'dark', got " .. tostring(variant))

  -- Must set before clearing so dependent plugins know the variant
  vim.o.background = (variant == "light") and "light" or "dark"
  vim.g.colors_name = "alabaster_" .. variant

  -- Clear all existing highlights
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end

  -- Re-set name after clear (clear resets it)
  vim.g.colors_name = "alabaster_" .. variant

  local p = palettes[variant]
  local highlights = build_highlights(p)

  for _, entry in ipairs(highlights) do
    local ok, err = pcall(vim.api.nvim_set_hl, 0, entry[1], entry[2])
    if not ok then
      vim.notify("alabaster: failed to set hl " .. entry[1] .. ": " .. err, vim.log.levels.WARN)
    end
  end
end

return M
