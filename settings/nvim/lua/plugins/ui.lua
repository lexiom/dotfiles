return {
  -- {
  --   'projekt0n/github-nvim-theme',
  --   name = 'github-theme',
  --   lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   opts = {
  --     -- options = { transparent = true, },
  --   },
  --   config = function(_, opts)
  --     require('github-theme').setup(opts)
  --     vim.cmd('colorscheme github_light_high_contrast')
  --   end,
  -- },
  {
    dir = vim.fn.stdpath('config'),
    name = 'parchment',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function(_, opts)
      require("themes.colorscheme.parchment")
    end,
  },
  { -- Statusline
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- optional
    },
    event = "VeryLazy",
    config = function()
      require("lualine").setup({
        options = {
          theme = require("themes.lualine.parchment"),
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
