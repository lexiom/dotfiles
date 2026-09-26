return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },

    opts = {
      interactions = {
        chat = {
          adapter = "cursor_cli",
        },
      },
      display = {
        chat = {
          window = {
            layout = "buffer",
          },
        },
      },
    },
  },
}
