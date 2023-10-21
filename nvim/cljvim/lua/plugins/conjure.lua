return {
  {
    "Olical/conjure",
    ft = { "clojure", "fennel" },
    branch = "master",
    config = function(_, opts)
      vim.g["conjure#mapping#doc_word"] = "K"
      vim.g["conjure#client#clojure#nrepl#eval#auto_require"] = false
      vim.g["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = false
      vim.g["conjure#client#clojure#nrepl#test#current_form_names"] = { "deftest", "defflow", "defspec" }
    end,
  },
  {
    "clojure-vim/vim-jack-in",
    dependencies = {
      "radenling/vim-dispatch-neovim",
      "tpope/vim-dispatch",
    },
  },
}
