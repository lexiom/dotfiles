return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "PaterJason/cmp-conjure",
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local function has_words_before()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return (
          (col ~= 0) and (((vim.api.nvim_buf_get_lines(0, (line - 1), line, true))[1]):sub(col, col):match("%s") == nil)
        )
      end
      local function forward(fallback)
        if cmp.visible() then
          return cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          return luasnip.expand_or_jump()
        elseif has_words_before() then
          return cmp.complete()
        elseif "else" then
          return fallback()
        else
          return nil
        end
      end
      local function backward(fallback)
        if cmp.visible() then
          return cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          return luasnip.jump(-1)
        elseif "else" then
          return fallback()
        else
          return nil
        end
      end
      return {
        completion = {
          completeopt = "menu,menuone,noselect",
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
          ["<Tab>"] = cmp.mapping(forward, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(backward, { "i", "s" }),
        }),
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "conjure" } })),
      }
    end,
  },
}
