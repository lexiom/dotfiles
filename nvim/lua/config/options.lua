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

-- set python host
vim.g.python3_host_prog = "/home/alexandre/.local/share/mise/installs/python/3.12/bin/python"
