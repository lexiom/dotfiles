return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nil_ls = {},
        zls = {
          -- settings = {
          --   semantic_tokens = "full",
          --   warn_style = false,
          --   highlight_global_var_declarations = false,
          --   enable_inlay_hints = true,
          --   inlay_hints_show_builtin = true,
          --   inlay_hints_exclude_single_argument = true,
          --   inlay_hints_hide_redundant_param_names = true,
          --   inlay_hints_hide_redundant_param_names_last_token = true,
          --   dangerous_comptime_experiments_do_not_enable = true,
          --   skip_std_references = true,
          --   record_session = true,
          -- },
        },
      },
    },
  },
}
