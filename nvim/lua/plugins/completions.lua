return {
  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      opts.completion = {
        completeopt = "menu,menuone,noinsert,noselect",
      }
      local cmp = require("cmp")
      opts.preselect = cmp.PreselectMode.None
      opts.mapping = cmp.mapping.preset.insert(vim.tbl_deep_extend("force", opts.mapping, {
        ["<CR>"] = LazyVim.cmp.confirm({ select = false }),
      }))
    end,
  },
}
