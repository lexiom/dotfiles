return {
 {
    dir = vim.fn.stdpath('config'),
    name = 'grayscale',
    lazy = false, -- makes sure it's loaded on startup
    priority = 1000, -- makes sure it's loaded before everything else
    config = function()
      vim.o.background = "light"
      require("themes.colorscheme.grayscale-light")
    end,
  },
  { -- Statusline
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("lualine").setup({
        options = {
          theme = require("themes.lualine.grayscale-light"),
          icons_enabled = false,
        },
      })
    end,
  },
  { -- Helps you remember your keybindings
    "folke/which-key.nvim",
    event = "VimEnter", -- Sets the loading event to "VimEnter"
    opts = {
      -- Delay between pressing a key and opening which-key (milliseconds)
      -- This setting is independent of vim.o.timeoutlen
      delay = 0,
      icons = {
        -- Set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = "<Up> ",
          Down = "<Down> ",
          Left = "<Left> ",
          Right = "<Right> ",
          C = "<C-…> ",
          M = "<M-…> ",
          D = "<D-…> ",
          S = "<S-…> ",
          CR = "<CR> ",
          Esc = "<Esc> ",
          ScrollWheelDown = "<ScrollWheelDown> ",
          ScrollWheelUp = "<ScrollWheelUp> ",
          NL = "<NL> ",
          BS = "<BS> ",
          Space = "<Space> ",
          Tab = "<Tab> ",
          F1 = "<F1>",
          F2 = "<F2>",
          F3 = "<F3>",
          F4 = "<F4>",
          F5 = "<F5>",
          F6 = "<F6>",
          F7 = "<F7>",
          F8 = "<F8>",
          F9 = "<F9>",
          F10 = "<F10>",
          F11 = "<F11>",
          F12 = "<F12>",
        },
      },
      -- Document existing key chains
      spec = {
        { "<leader>s", group = "[S]earch" },
        { "<leader>t", group = "[T]oggle" },
        { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
      },
    },
  },
}
