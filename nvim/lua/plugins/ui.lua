return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "LazyFile",
    opts = {
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "alpha",
          "dashboard",
          "csv",
          "fzf",
          "help",
          "json",
          "lazy",
          "lazyterm",
          "mason",
          "neo-tree",
          "notify",
          "toggleterm",
          "trouble",
          "Trouble",
        },
      },
    },
  },
}
