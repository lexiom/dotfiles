return {
  {
    "nvim-orgmode/orgmode",
    -- event = "VeryLazy",
    config = function()
      -- Load treesitter grammar for org
      require("orgmode").setup_ts_grammar()
      -- Setup orgmode
      require("orgmode").setup({
        org_agenda_files = "~/Projects/**/*",
        -- org_default_notes_file = "~/Projects/refile.org",
      })
    end,
  },
}
