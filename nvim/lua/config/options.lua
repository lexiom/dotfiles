-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- disable relative line numbering
opt.relativenumber = false

-- disable empty space filling with special characters
opt.list = false

-- set virtual edit to only highlight text, which is vim's default behavior
-- this was necessary to change because lazyvim sets it to "block" by default
-- https://vimdoc.sourceforge.net/htmldoc/options.html#'virtualedit'
opt.virtualedit = ""

-- disable double quotes concealing in JSON files
opt.conceallevel = 0

-- disable zig autoformat on save
vim.g.zig_fmt_autosave = 0

-- set python host
vim.g.python3_host_prog = "python"

-- set clipboard behavior
vim.o.clipboard = "unnamedplus"

-- disable autocomplete on Enter
-- vim.o.completeopt = "menuone,noselect,preview"
