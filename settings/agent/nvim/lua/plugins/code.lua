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
  { -- Tree-sitter parsers and queries (requires tree-sitter CLI).
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local treesitter = require("nvim-treesitter")
      treesitter.setup()
      treesitter.install({
        "asm",
        "bash",
        "c",
        "cpp",
        "dockerfile",
        "json",
        "nix",
        "odin",
        "python",
        "terraform",
        "toml",
        "yaml",
      })
    end,
  },
}
