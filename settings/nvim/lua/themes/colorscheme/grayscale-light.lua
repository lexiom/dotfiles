-- grayscale-light.nvim
-- Minimal grayscale colorscheme

vim.cmd("highlight clear")

if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "grayscale-light"

local set = vim.api.nvim_set_hl

local c = {
  bg         = "#f2f2f2", -- main background
  fg         = "#000000", -- main foreground

  grayscale1 = "#e5e5e5", -- subtle background
  grayscale2 = "#dedede", -- selection / borders
  grayscale3 = "#cccccc", -- non characters
  grayscale4 = "#747474", -- comments / secondary text
  grayscale5 = "#585858", -- muted gray foreground
  grayscale6 = "#3f3f3f", -- strong gray foreground
}

-- UI
set(0, "Normal",       { fg = c.fg, bg = c.bg })
set(0, "NormalFloat",  { fg = c.fg, bg = c.grayscale1 })
set(0, "FloatBorder",  { fg = c.grayscale4, bg = c.grayscale1 })

set(0, "Cursor",       { fg = c.bg, bg = c.grayscale4 })
set(0, "CursorLine",   { bg = c.grayscale1 })
set(0, "CursorColumn", { bg = c.grayscale1 })

set(0, "LineNr",       { fg = c.grayscale4, bg = c.bg })
set(0, "CursorLineNr", { fg = c.fg, bg = c.grayscale1, bold = true })

set(0, "SignColumn",   { fg = c.grayscale4, bg = c.bg })
set(0, "FoldColumn",   { fg = c.grayscale4, bg = c.bg })

set(0, "Visual",       { bg = c.grayscale2 })
set(0, "Search",       { fg = c.fg, bg = c.grayscale2, bold = true })
set(0, "IncSearch",    { fg = c.bg, bg = c.fg })

set(0, "StatusLine",   { fg = c.fg, bg = c.grayscale2, bold = true })
set(0, "StatusLineNC", { fg = c.grayscale5, bg = c.grayscale1 })
set(0, "VertSplit",    { fg = c.grayscale2, bg = c.bg })
set(0, "WinSeparator", { fg = c.grayscale2, bg = c.bg })

set(0, "Pmenu",        { fg = c.fg, bg = c.grayscale1 })
set(0, "PmenuSel",     { fg = c.bg, bg = c.fg })
set(0, "PmenuSbar",    { bg = c.grayscale2 })
set(0, "PmenuThumb",   { bg = c.grayscale5 })

set(0, "TabLine",      { fg = c.grayscale5, bg = c.grayscale1 })
set(0, "TabLineSel",   { fg = c.fg, bg = c.bg, bold = true })
set(0, "TabLineFill",  { bg = c.grayscale1 })

set(0, "Directory",    { fg = c.fg, bold = true })
set(0, "Title",        { fg = c.fg, bold = true })
set(0, "Question",     { fg = c.fg, bold = true })
set(0, "MoreMsg",      { fg = c.fg, bold = true })

set(0, "Whitespace",   { fg = c.grayscale3 })
set(0, "EndOfBuffer",  { fg = c.grayscale3 })

-- Diagnostics
set(0, "DiagnosticError", { fg = c.fg, bold = true })
set(0, "DiagnosticWarn",  { fg = c.grayscale6, bold = true })
set(0, "DiagnosticInfo",  { fg = c.grayscale5 })
set(0, "DiagnosticHint",  { fg = c.grayscale4 })

set(0, "DiagnosticUnderlineError", { undercurl = true })
set(0, "DiagnosticUnderlineWarn",  { underline = true })
set(0, "DiagnosticUnderlineInfo",  { underline = true })
set(0, "DiagnosticUnderlineHint",  { underline = true })

-- Syntax
set(0, "Comment",    { fg = c.grayscale4, italic = true })

set(0, "Constant",   { fg = c.grayscale6 })
set(0, "String",     { fg = c.grayscale6, italic = true })
set(0, "Character",  { fg = c.grayscale6 })
set(0, "Number",     { fg = c.grayscale6 })
set(0, "Boolean",    { fg = c.grayscale6, bold = true })
set(0, "Float",      { fg = c.grayscale6 })

set(0, "Identifier", { fg = c.fg })
set(0, "Function",   { fg = c.fg, bold = false })

set(0, "Statement",   { fg = c.fg, bold = true })
set(0, "Conditional", { fg = c.fg, bold = true })
set(0, "Repeat",      { fg = c.fg, bold = true })
set(0, "Label",       { fg = c.fg, bold = true })
set(0, "Operator",    { fg = c.fg })
set(0, "Keyword",     { fg = c.fg, bold = false })
set(0, "Exception",   { fg = c.fg, bold = true })

set(0, "PreProc",    { fg = c.grayscale6, bold = true })
set(0, "Include",    { fg = c.grayscale6, bold = true })
set(0, "Define",     { fg = c.grayscale6, bold = true })
set(0, "Macro",      { fg = c.grayscale6, bold = true })

set(0, "Type",         { fg = c.fg, bold = false })
set(0, "StorageClass", { fg = c.fg, bold = true })
set(0, "Structure",    { fg = c.fg, bold = false })
set(0, "Typedef",      { fg = c.fg, bold = true })

set(0, "Special",     { fg = c.grayscale5 })
set(0, "SpecialChar", { fg = c.grayscale5 })
set(0, "Delimiter",   { fg = c.grayscale6 })

set(0, "MatchParen", { fg = c.fg, bg = c.grayscale2, bold = true })
set(0, "Todo",       { fg = c.fg, bg = c.grayscale2, bold = true })

-- Diffs
set(0, "DiffAdd",    { fg = c.fg, bg = c.grayscale1 })
set(0, "DiffChange", { fg = c.fg, bg = c.grayscale1 })
set(0, "DiffDelete", { fg = c.grayscale4, bg = c.grayscale1 })
set(0, "DiffText",   { fg = c.fg, bg = c.grayscale2, bold = true })

-- Git signs
set(0, "GitSignsAdd",    { fg = c.grayscale5 })
set(0, "GitSignsChange", { fg = c.grayscale5 })
set(0, "GitSignsDelete", { fg = c.grayscale5 })

-- Treesitter
set(0, "@comment",         { link = "Comment" })

set(0, "@function",        { link = "Function" })
set(0, "@function.call",   { fg = c.fg, bold = true })
set(0, "@method",          { fg = c.fg, bold = true })
set(0, "@method.call",     { fg = c.fg, bold = true })
set(0, "@constructor",     { fg = c.fg })

set(0, "@keyword",          { link = "Keyword" })
set(0, "@keyword.function", { fg = c.fg, bold = true })
set(0, "@conditional",      { link = "Conditional" })
set(0, "@repeat",           { link = "Repeat" })

set(0, "@type",         { link = "Type" })
set(0, "@type.builtin", { fg = c.fg, bold = true })

set(0, "@variable",         { fg = c.fg })
set(0, "@variable.builtin", { fg = c.fg, bold = true })

set(0, "@constant",         { link = "Constant" })
set(0, "@constant.builtin", { fg = c.fg, bold = true })

set(0, "@string",      { link = "String" })
set(0, "@number",      { link = "Number" })
set(0, "@boolean",     { link = "Boolean" })
set(0, "@operator",    { link = "Operator" })

set(0, "@punctuation",           { fg = c.grayscale6 })
set(0, "@punctuation.delimiter", { fg = c.grayscale6 })

-- LSP semantic tokens
set(0, "@lsp.type.function",  { fg = c.fg, bold = true })
set(0, "@lsp.type.method",    { fg = c.fg, bold = true })
set(0, "@lsp.type.class",     { fg = c.fg, bold = true })
set(0, "@lsp.type.struct",    { fg = c.fg, bold = true })
set(0, "@lsp.type.enum",      { fg = c.fg, bold = true })
set(0, "@lsp.type.interface", { fg = c.fg, bold = true })
set(0, "@lsp.type.comment",   { fg = c.grayscale4, italic = true })
