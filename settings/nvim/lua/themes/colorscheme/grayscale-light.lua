-- grayscalescale-light.nvim
-- Minimal grayscalescale colorscheme

vim.cmd("highlight clear")

if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "grayscalescale-light"

local set = vim.api.nvim_set_hl

-----------------------------------------------------------------------------
-- Palette
-----------------------------------------------------------------------------

local c = {
  bg = "#f0f0f0", -- main background

  grayscale1 = "#e0e0e0", -- subtle background
  grayscale2 = "#d0d0d0", -- selections / borders
  grayscale3 = "#b0b0b0", -- invisible characters
  grayscale4 = "#808080", -- comments / inactive text
  grayscale5 = "#404040", -- secondary foreground
  grayscale6 = "#000000", -- primary foreground
}

-----------------------------------------------------------------------------
-- Editor
-----------------------------------------------------------------------------

set(0, "Normal",       { fg = c.grayscale6, bg = c.bg })
set(0, "NormalFloat",  { fg = c.grayscale6, bg = c.grayscale1 })
set(0, "FloatBorder",  { fg = c.grayscale4, bg = c.grayscale1 })

set(0, "Cursor",       { fg = c.bg, bg = c.grayscale6 })
set(0, "CursorLine",   { bg = c.grayscale1 })
set(0, "CursorColumn", { bg = c.grayscale1 })

set(0, "LineNr",       { fg = c.grayscale4, bg = c.bg })
set(0, "CursorLineNr", { fg = c.grayscale6, bg = c.grayscale1, bold = true })
set(0, "FoldColumn",   { fg = c.grayscale4, bg = c.bg })
set(0, "SignColumn",   { fg = c.grayscale4, bg = c.bg })

set(0, "Whitespace",  { fg = c.grayscale3 })
set(0, "NonText",     { fg = c.grayscale3 })
set(0, "EndOfBuffer", { fg = c.grayscale3 })

set(0, "ColorColumn", { bg = c.grayscale1 })

-----------------------------------------------------------------------------
-- Selections / searching / matching
-----------------------------------------------------------------------------

set(0, "Visual",    { bg = c.grayscale2 })
set(0, "VisualNOS", { bg = c.grayscale2 })

set(0, "Search",    { fg = c.grayscale6, bg = c.grayscale2 })
set(0, "CurSearch", { fg = c.bg, bg = c.grayscale6, bold = true })
set(0, "IncSearch", { fg = c.bg, bg = c.grayscale6, bold = true })

set(0, "MatchParen", { fg = c.grayscale6, bg = c.grayscale2, bold = true })

-----------------------------------------------------------------------------
-- Window separators / status / tabs
-----------------------------------------------------------------------------

set(0, "WinSeparator", { fg = c.grayscale2, bg = c.bg })
set(0, "VertSplit",    { link = "WinSeparator" })

set(0, "StatusLine",   { fg = c.grayscale6, bg = c.grayscale2, bold = true })
set(0, "StatusLineNC", { fg = c.grayscale4, bg = c.grayscale1 })

set(0, "TabLine",     { fg = c.grayscale4, bg = c.grayscale1 })
set(0, "TabLineSel",  { fg = c.grayscale6, bg = c.bg, bold = true })
set(0, "TabLineFill", { bg = c.grayscale1 })

-----------------------------------------------------------------------------
-- Popup menu
-----------------------------------------------------------------------------

set(0, "Pmenu",      { fg = c.grayscale6, bg = c.grayscale1 })
set(0, "PmenuSel",   { fg = c.bg, bg = c.grayscale6 })
set(0, "PmenuSbar",  { bg = c.grayscale2 })
set(0, "PmenuThumb", { bg = c.grayscale4 })

-----------------------------------------------------------------------------
-- Messages / headings
-----------------------------------------------------------------------------

set(0, "Directory", { fg = c.grayscale6, bold = true })
set(0, "Title",     { fg = c.grayscale6, bold = true })
set(0, "Question",  { fg = c.grayscale6, bold = true })
set(0, "MoreMsg",   { fg = c.grayscale5 })

set(0, "Todo", {
  fg = c.grayscale6,
  bg = c.grayscale2,
  bold = true,
})

-----------------------------------------------------------------------------
-- Diagnostics
-----------------------------------------------------------------------------

set(0, "DiagnosticError", { fg = c.grayscale6, bold = true })
set(0, "DiagnosticWarn",  { fg = c.grayscale5, bold = true })
set(0, "DiagnosticInfo",  { fg = c.grayscale5 })
set(0, "DiagnosticHint",  { fg = c.grayscale4 })

set(0, "DiagnosticUnderlineError", { undercurl = true })
set(0, "DiagnosticUnderlineWarn",  { undercurl = true })
set(0, "DiagnosticUnderlineInfo",  { underline = true })
set(0, "DiagnosticUnderlineHint",  { underline = true })

set(0, "DiagnosticVirtualTextError", { fg = c.grayscale5 })
set(0, "DiagnosticVirtualTextWarn",  { fg = c.grayscale5 })
set(0, "DiagnosticVirtualTextInfo",  { fg = c.grayscale4 })
set(0, "DiagnosticVirtualTextHint",  { fg = c.grayscale4 })

-----------------------------------------------------------------------------
-- Base syntax
-----------------------------------------------------------------------------

-- Comments
set(0, "Comment", { fg = c.grayscale4, italic = true })

-- Literals
set(0, "Constant",  { fg = c.grayscale5 })
set(0, "String",    { fg = c.grayscale5, italic = true })
set(0, "Character", { link = "String" })
set(0, "Number",    { fg = c.grayscale5 })
set(0, "Float",     { link = "Number" })
set(0, "Boolean",   { fg = c.grayscale5, bold = true })

-- Names
set(0, "Identifier", { fg = c.grayscale6 })
set(0, "Function",   { fg = c.grayscale6 })

-- Keywords / control flow
set(0, "Statement",   { fg = c.grayscale6, bold = true })
set(0, "Conditional", { link = "Statement" })
set(0, "Repeat",      { link = "Statement" })
set(0, "Label",       { link = "Statement" })
set(0, "Keyword",     { link = "Statement" })
set(0, "Exception",   { link = "Statement" })

set(0, "Operator", { fg = c.grayscale5 })

-- Types
set(0, "Type",         { fg = c.grayscale5 })
set(0, "StorageClass", { fg = c.grayscale6, bold = true })
set(0, "Structure",    { link = "Type" })
set(0, "Typedef",      { fg = c.grayscale6, bold = true })

-- Preprocessor
set(0, "PreProc", { fg = c.grayscale5 })

set(0, "Include", { link = "PreProc" })
set(0, "Define",  { link = "PreProc" })
set(0, "Macro",   { link = "PreProc" })

-- Misc syntax
set(0, "Special",     { fg = c.grayscale5 })
set(0, "SpecialChar", { link = "Special" })
set(0, "Delimiter",   { fg = c.grayscale5 })

-----------------------------------------------------------------------------
-- Diffs / version control
-----------------------------------------------------------------------------

set(0, "DiffAdd",    { fg = c.grayscale6, bg = c.grayscale1 })
set(0, "DiffChange", { fg = c.grayscale6, bg = c.grayscale1 })
set(0, "DiffDelete", { fg = c.grayscale4, bg = c.grayscale1 })
set(0, "DiffText",   { fg = c.grayscale6, bg = c.grayscale2, bold = true })

set(0, "GitSignsAdd",    { fg = c.grayscale5 })
set(0, "GitSignsChange", { fg = c.grayscale4 })
set(0, "GitSignsDelete", { fg = c.grayscale4 })

-----------------------------------------------------------------------------
-- Tree-sitter
-----------------------------------------------------------------------------

-- Comments
set(0, "@comment",               { link = "Comment" })
set(0, "@comment.documentation", { fg = c.grayscale4, italic = true })

-- Variables
set(0, "@variable",                   { fg = c.grayscale6 })
set(0, "@variable.builtin",           { fg = c.grayscale5, italic = true })
set(0, "@variable.parameter",         { fg = c.grayscale6 })
set(0, "@variable.parameter.builtin", { fg = c.grayscale5, italic = true })
set(0, "@variable.member",            { fg = c.grayscale6 })

-- Functions
set(0, "@function",         { fg = c.grayscale6 })
set(0, "@function.call",    { fg = c.grayscale6 })
set(0, "@function.method",  { fg = c.grayscale6 })
set(0, "@function.builtin", { fg = c.grayscale5 })

set(0, "@constructor", { fg = c.grayscale6, bold = true })

-- Keywords
set(0, "@keyword",             { link = "Keyword" })
set(0, "@keyword.function",    { link = "Keyword" })
set(0, "@keyword.conditional", { link = "Conditional" })
set(0, "@keyword.repeat",      { link = "Repeat" })
set(0, "@keyword.exception",   { link = "Exception" })
set(0, "@keyword.return",      { link = "Keyword" })

-- Types
set(0, "@type",         { link = "Type" })
set(0, "@type.builtin", { fg = c.grayscale5, bold = true })

-- Constants / literals
set(0, "@constant",         { link = "Constant" })
set(0, "@constant.builtin", { fg = c.grayscale5, bold = true })

set(0, "@string",    { link = "String" })
set(0, "@character", { link = "Character" })
set(0, "@number",    { link = "Number" })
set(0, "@boolean",   { link = "Boolean" })

-- Operators / punctuation
set(0, "@operator",              { link = "Operator" })
set(0, "@punctuation.delimiter", { link = "Delimiter" })
set(0, "@punctuation.bracket",   { fg = c.grayscale5 })
set(0, "@punctuation.special",   { fg = c.grayscale5 })

-- Markup
set(0, "@markup.heading", { fg = c.grayscale6, bold = true })
set(0, "@markup.strong",  { bold = true })
set(0, "@markup.italic",  { italic = true })
set(0, "@markup.link",    { fg = c.grayscale5, underline = true })

-----------------------------------------------------------------------------
-- LSP semantic tokens
-----------------------------------------------------------------------------

set(0, "@lsp.type.comment", { link = "Comment" })

set(0, "@lsp.type.function", { fg = c.grayscale6 })
set(0, "@lsp.type.method",   { fg = c.grayscale6 })

set(0, "@lsp.type.class",     { fg = c.grayscale5, bold = true })
set(0, "@lsp.type.struct",    { fg = c.grayscale5, bold = true })
set(0, "@lsp.type.enum",      { fg = c.grayscale5, bold = true })
set(0, "@lsp.type.interface", { fg = c.grayscale5, bold = true })

set(0, "@lsp.type.parameter", { fg = c.grayscale6 })
set(0, "@lsp.type.property",  { fg = c.grayscale6 })
set(0, "@lsp.type.variable",  { fg = c.grayscale6 })
