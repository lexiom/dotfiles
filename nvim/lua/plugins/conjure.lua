return {
  {
    "Olical/conjure",
    ft = { "clojure" },
    config = function(_, opts)
      require("conjure.main").main()
      require("conjure.mapping")["on-filetype"]()
    end,
    init = function() end,
  },
  {
    "clojure-vim/vim-jack-in",
    dependencies = {
      "radenling/vim-dispatch-neovim",
      "tpope/vim-dispatch",
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        clojure = { "cljstyle" },
      },
    },
  },
}
