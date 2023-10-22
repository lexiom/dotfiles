-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- disable relative line numbering
vim.opt.relativenumber = false

-- disable empty space filling with special characters
vim.opt.list = false

-- set python host
vim.g.python3_host_prog = "/home/linuxbrew/.linuxbrew/bin/python3"

-- set virtual edit to only highlight text, which is vim's default behavior
-- this was necessary to change because lazyvim sets it to "block" by default
-- https://vimdoc.sourceforge.net/htmldoc/options.html#'virtualedit'
vim.opt.virtualedit = ""
