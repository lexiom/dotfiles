return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "clojure",
        "org",
        "sql",
      })
      -- opts.highlight.enable = { "org" }
      -- opts.additional_vim_regex_highlighting = { "org" }
    end,
  },
}
