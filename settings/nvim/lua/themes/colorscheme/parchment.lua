-- parchment.nvim
-- Minimal parchment colorscheme

vim.cmd("highlight clear")

if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "parchment"

local set = vim.api.nvim_set_hl

local c = {
  bg         = "#f4f1e8", -- main background
  fg         = "#000000", -- main foreground

  parchment1 = "#e4dece", -- subtle background
  parchment2 = "#dccdb4", -- selection / borders
  parchment3 = "#8f7654", -- comments / secondary text
  parchment4 = "#76562f", -- muted brown foreground
  parchment5 = "#3a2818", -- strong brown foreground
}

-- UI
set(0, "Normal",       { fg = c.fg, bg = c.bg })
set(0, "NormalFloat",  { fg = c.fg, bg = c.parchment1 })
set(0, "FloatBorder",  { fg = c.parchment3, bg = c.parchment1 })

set(0, "Cursor",       { fg = c.bg, bg = c.fg })
set(0, "CursorLine",   { bg = c.parchment1 })
set(0, "CursorColumn", { bg = c.parchment1 })

set(0, "LineNr",       { fg = c.parchment3, bg = c.bg })
set(0, "CursorLineNr", { fg = c.fg, bg = c.parchment1, bold = true })

set(0, "SignColumn",   { fg = c.parchment3, bg = c.bg })
set(0, "FoldColumn",   { fg = c.parchment3, bg = c.bg })

set(0, "Visual",       { bg = c.parchment2 })
set(0, "Search",       { fg = c.fg, bg = c.parchment2, bold = true })
set(0, "IncSearch",    { fg = c.bg, bg = c.fg })

set(0, "StatusLine",   { fg = c.fg, bg = c.parchment2, bold = true })
set(0, "StatusLineNC", { fg = c.parchment4, bg = c.parchment1 })
set(0, "VertSplit",    { fg = c.parchment2, bg = c.bg })
set(0, "WinSeparator", { fg = c.parchment2, bg = c.bg })

set(0, "Pmenu",        { fg = c.fg, bg = c.parchment1 })
set(0, "PmenuSel",     { fg = c.bg, bg = c.fg })
set(0, "PmenuSbar",    { bg = c.parchment2 })
set(0, "PmenuThumb",   { bg = c.parchment4 })

set(0, "TabLine",      { fg = c.parchment4, bg = c.parchment1 })
set(0, "TabLineSel",   { fg = c.fg, bg = c.bg, bold = true })
set(0, "TabLineFill",  { bg = c.parchment1 })

set(0, "Directory",    { fg = c.fg, bold = true })
set(0, "Title",        { fg = c.fg, bold = true })
set(0, "Question",     { fg = c.fg, bold = true })
set(0, "MoreMsg",      { fg = c.fg, bold = true })

-- Diagnostics
-- Still monochromatic: severity is expressed by weight/underline, not hue.
set(0, "DiagnosticError", { fg = c.fg, bold = true })
set(0, "DiagnosticWarn",  { fg = c.parchment5, bold = true })
set(0, "DiagnosticInfo",  { fg = c.parchment4 })
set(0, "DiagnosticHint",  { fg = c.parchment3 })

set(0, "DiagnosticUnderlineError", { undercurl = true })
set(0, "DiagnosticUnderlineWarn",  { underline = true })
set(0, "DiagnosticUnderlineInfo",  { underline = true })
set(0, "DiagnosticUnderlineHint",  { underline = true })

-- Syntax
set(0, "Comment",    { fg = c.parchment3, italic = true })

set(0, "Constant",   { fg = c.parchment5 })
set(0, "String",     { fg = c.parchment5 })
set(0, "Character",  { fg = c.parchment5 })
set(0, "Number",     { fg = c.parchment5 })
set(0, "Boolean",    { fg = c.fg, bold = true })
set(0, "Float",      { fg = c.parchment5 })

set(0, "Identifier", { fg = c.fg })
set(0, "Function",   { fg = c.fg, bold = true })

set(0, "Statement",   { fg = c.fg, bold = true })
set(0, "Conditional", { fg = c.fg, bold = true })
set(0, "Repeat",      { fg = c.fg, bold = true })
set(0, "Label",       { fg = c.fg, bold = true })
set(0, "Operator",    { fg = c.fg })
set(0, "Keyword",     { fg = c.fg, bold = true })
set(0, "Exception",   { fg = c.fg, bold = true })

set(0, "PreProc",    { fg = c.parchment5, bold = true })
set(0, "Include",    { fg = c.parchment5, bold = true })
set(0, "Define",     { fg = c.parchment5, bold = true })
set(0, "Macro",      { fg = c.parchment5, bold = true })

set(0, "Type",         { fg = c.fg, bold = true })
set(0, "StorageClass", { fg = c.fg, bold = true })
set(0, "Structure",    { fg = c.fg, bold = true })
set(0, "Typedef",      { fg = c.fg, bold = true })

set(0, "Special",     { fg = c.parchment4 })
set(0, "SpecialChar", { fg = c.parchment4 })
set(0, "Delimiter",   { fg = c.parchment4 })

set(0, "Todo", { fg = c.fg, bg = c.parchment2, bold = true })

-- Diffs
set(0, "DiffAdd",    { fg = c.fg, bg = c.parchment1 })
set(0, "DiffChange", { fg = c.fg, bg = c.parchment1 })
set(0, "DiffDelete", { fg = c.parchment3, bg = c.parchment1 })
set(0, "DiffText",   { fg = c.fg, bg = c.parchment2, bold = true })

-- Git signs
set(0, "GitSignsAdd",    { fg = c.parchment4 })
set(0, "GitSignsChange", { fg = c.parchment4 })
set(0, "GitSignsDelete", { fg = c.parchment4 })

-- Treesitter
set(0, "@comment",         { link = "Comment" })

set(0, "@function",        { link = "Function" })
set(0, "@function.call",   { fg = c.fg, bold = true })
set(0, "@method",          { fg = c.fg, bold = true })
set(0, "@method.call",     { fg = c.fg, bold = true })
set(0, "@constructor",     { fg = c.fg, bold = true })

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
set(0, "@punctuation", { fg = c.parchment4 })

-- LSP semantic tokens
set(0, "@lsp.type.function",  { fg = c.fg, bold = true })
set(0, "@lsp.type.method",    { fg = c.fg, bold = true })
set(0, "@lsp.type.class",     { fg = c.fg, bold = true })
set(0, "@lsp.type.struct",    { fg = c.fg, bold = true })
set(0, "@lsp.type.enum",      { fg = c.fg, bold = true })
set(0, "@lsp.type.interface", { fg = c.fg, bold = true })
set(0, "@lsp.type.comment",   { fg = c.parchment3, italic = true })
