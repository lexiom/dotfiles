return {
  {
    "julienvincent/nvim-paredit",
    lazy = true,
    ft = { "clojure", "fennel" },
    config = function(_, opts)
      local paredit = require("nvim-paredit")
      local function _3_()
        return paredit.cursor.place_cursor(
          paredit.wrap.wrap_enclosing_form_under_cursor("(", ")"),
          { mode = "insert", placement = "inner_end" }
        )
      end
      local function _4_()
        return paredit.cursor.place_cursor(
          paredit.wrap.wrap_element_under_cursor("(", ")"),
          { mode = "insert", placement = "inner_end" }
        )
      end
      local function _5_()
        return paredit.cursor.place_cursor(
          paredit.wrap.wrap_enclosing_form_under_cursor("( ", ")"),
          { mode = "insert", placement = "inner_start" }
        )
      end
      local function _6_()
        return paredit.cursor.place_cursor(
          paredit.wrap.wrap_element_under_cursor("( ", ")"),
          { mode = "insert", placement = "inner_start" }
        )
      end
      require("nvim-paredit").setup({
        keys = {
          ["<localleader>I"] = { _3_, "Wrap form insert tail" },
          ["<localleader>W"] = { _4_, "Wrap element insert tail" },
          ["<localleader>i"] = { _5_, "Wrap form insert head" },
          ["<localleader>w"] = { _6_, "Wrap element insert head" },
        },
      })
    end,
  },
  {
    "julienvincent/nvim-paredit-fennel",
    dependencies = { "julienvincent/nvim-paredit" },
    lazy = true,
    ft = { "fennel" },
    config = function(_, opts)
      local paredit_fnl = require("nvim-paredit-fennel")
      return paredit_fnl.setup()
    end,
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function(_, opts)
      local surround = require("nvim-surround")
      return surround.setup()
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
}
