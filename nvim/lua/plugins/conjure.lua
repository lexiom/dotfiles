return {
  {
    "Olical/conjure",
    ft = { "clojure" },
    config = function(_, opts)
      require("conjure.main").main()
      require("conjure.mapping")["on-filetype"]()
    end,
  },
}
