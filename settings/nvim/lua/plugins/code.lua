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
  { -- Syntax highlighting (requires tree-sitter CLI installed).
    "romus204/tree-sitter-manager.nvim",
    dependencies = {},
    config = function()
      require("tree-sitter-manager").setup({
          ensure_installed = {
              "asm", "bash", "c", "cpp", "dockerfile", "json",
              "odin", "python", "terraform", "toml", "yaml",
          },
          nerdfont = false,
      })
    end,
  },
}
