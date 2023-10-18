return {
  {
    "Olical/conjure",
    ft = { "clojure" },
    dependencies = {
      -- code completion
      {
        "PaterJason/cmp-conjure",
        config = function()
          local cmp = require("cmp")
          local config = cmp.get_config()
          table.insert(config.sources, {
            name = "buffer",
            option = {
              sources = {
                { name = "conjure" },
              },
            },
          })
          cmp.setup(config)
        end,
      },
    },
  },
  {
    "clojure-vim/vim-jack-in",
    dependencies = {
      "radenling/vim-dispatch-neovim",
      "tpope/vim-dispatch",
    },
  },
}
