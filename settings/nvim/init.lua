-------------
-- GLOBALS --
-------------

-- Set to true if a Nerd Font is installed and set in the terminal
vim.g.have_nerd_font = true

-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set the local path to Python's pynvim package
vim.g.python3_host_prog = '~/.local/share/pynvim/venv/bin/python3'

-- Enable syntax highlighting
vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")

-------------
-- OPTIONS --
-------------

-- Truecolor mode
vim.opt.termguicolors = true

-- Every wrapped line continues visually indented (same amount of space as the beginning of that line)
vim.o.breakindent = true

-- Show which line your cursor is on
vim.o.cursorline = true

-- Set expandtab, shiftwidth, and tabstop
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4

-- Case-insensitive searching unless \C or one or more capital letters in the search term
-- vim.o.ignorecase = true
-- vim.o.smartcase = true

-- Preview substitutions live as you type
vim.o.inccommand = "split"

-- Sets how Neovim will display certain whitespace characters in the editor
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣", space = "."}

-- Make line numbers default
vim.o.number = true

-- Enable relative line numbers
vim.o.relativenumber = true

-- Minimal number of screen lines to keep above and below the cursor
vim.o.scrolloff = 5

-- Hide the current mode
-- Since we will use a status line extension, no need to show the mode
vim.o.showmode = false

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

-- The waiting time (in ms) for a key code or a mapped key sequence to complete
vim.o.timeoutlen = 300

-- Enable persistent undo history
vim.o.undofile = true

-- Sets the waiting time (in ms) to write the swap file to disk (that is, if nothing is typed)
vim.o.updatetime = 250

-- Disable line wrapping
vim.o.wrap = false

-- Sync clipboard between OS and Neovim
-- Schedule the setting after `UiEnter` because it can increase startup-time
-- Remove this option if you want your OS clipboard to remain independent
-- See `:help "clipboard"`
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
      ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
  }
end)

--------------
-- AUTOCMDS --
--------------

-- Disable automatic continuation of comments on newline
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    command = "setlocal formatoptions-=cro"
})

-- Enable native Tree-sitter highlighting when a parser is available
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Set two spaces for some file types
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "bash", "json", "lua", "markdown", "nix", "toml", "yaml" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end
})

---------------
-- LAZY.NVIM --
---------------

-- Install `lazy.nvim` plugin manager
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-------------
-- MODULES --
-------------

require("lazy").setup({
  require("plugins.lsp"),
  require("plugins.nav"),
  require("plugins.ui"),
}, {
  rocks = {
    enabled = false,
  },
})

-------------
-- KEYMAPS --
-------------

-- Clear highlights on search when pressing `<Esc>` in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
