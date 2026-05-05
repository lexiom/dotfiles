return {
  { -- Tabbing in and out of brackets, parenthesis, quotes, etc.
      "kawre/neotab.nvim",
      event = "InsertEnter",
      opts = {},
  },
  { -- Automatic pairs for brackets, parenthesis, quotes, etc.
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
}
