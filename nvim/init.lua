-- Set US English as the default language
-- vim.cmd("language en_US")

-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if a Nerd Font is installed and set in the terminal
vim.g.have_nerd_font = true

-- Set tabstop, shiftwidth, and expandtab
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Make line numbers default
vim.opt.number = true

-- Enable relative line numbers
vim.opt.relativenumber = true

-- Hide the current mode
-- Since we will use a status line extension, no need to show the mode
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim
-- Schedule the setting after `UiEnter` because it can increase startup-time
-- Remove this option if you want your OS clipboard to remain independent
-- See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Every wrapped line continues visually indented (same amount of space as the beginning of that line)
vim.opt.breakindent = true

-- Disable line wrapping
vim.opt.wrap = false

-- Enable persistent undo history
vim.opt.undofile = true

-- Case-insensitive searching unless \C or one or more capital letters in the search term
-- vim.opt.ignorecase = true
-- vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Sets the waiting time (in ms) to write the swap file to disk (that is, if nothing is typed)
vim.opt.updatetime = 250

-- The waiting time (in ms) for a key code or a mapped key sequence to complete
vim.opt.timeoutlen = 300

-- Sets how Neovim will display certain whitespace characters in the editor
-- vim.opt.list = true
-- vim.opt.listchars = { tab = 'È ', trail = 'á', nbsp = '?' }

-- Preview substitutions live as you type
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 5

-- Clear highlights on search when pressing `<Esc>` in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- JSON spacing
vim.api.nvim_create_autocmd("FileType", {
    pattern = "json",
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.expandtab = true
    end
})

-- YAML spacing
vim.api.nvim_create_autocmd("FileType", {
    pattern = "yaml",
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.expandtab = true
    end
})

-- Terraform and HCL comment string
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("TerraformCommentString", { clear = true }),
  callback = function(ev)
    vim.bo[ev.buf].commentstring = "# %s"
  end,
  pattern = { "terraform", "hcl" },
})

-- Install `lazy.nvim` plugin manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    -- Helps you remember your keybindings
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to `VimEnter`
    opts = {
      -- Delay between pressing a key and opening which-key (milliseconds)
      -- This setting is independent of `vim.opt.timeoutlen`
      delay = 0,
      icons = {
        -- Set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- Don't forget to set a Nerd Font: this sets icons.keys to an empty table which will use
        -- the default `which-key.nvim` defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {},
      },
      -- Document existing key chains
      spec = {
        { '<leader>c', group = '[C]ode',     mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },
  {
    -- LSP configuration in Neovim
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { 'williamboman/mason.nvim', opts = {} },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      -- Useful status updates for LSP
      { 'j-hui/fidget.nvim', opts = {} },
      -- Allows extra capabilities provided by `nvim-cmp`
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end
          -- Rename the variable under your cursor
          -- Most Language Servers support renaming across files, etc
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
          -- WARN: This is not Goto Definition, this is Goto Declaration
          -- For example, in C this would take you to the header
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            return client:supports_method(method, bufnr)
          end

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while
          -- See `:help CursorHold` for information about when this is executed
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })

            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            -- When you move your cursor, the highlights will be cleared
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event_detach)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event_detach.buf }
              end,
            })
          end
          -- The following code creates a keymap to toggle inlay hints in
          -- your code, if the language server you are using supports them
          -- This may be unwanted, since they displace some of your code
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
          -- -- basedpyright specific settings
          -- -- Disable completions
          -- if client and client.name == 'basedpyright' then
          --   ---@diagnostic disable-next-line: assign-type-mismatch
          --   client.server_capabilities.completionProvider = false
          -- end
          -- Ruff specific settings
          if client and client.name == 'ruff' then
            -- Disable Ruff hover in favor of basedpyright
            client.server_capabilities.hoverProvider = false
            -- Perform some actions on save
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = event.buf,
              callback = function()
                -- Format code on save
                vim.lsp.buf.format { async = false, id = event.data.client_id }
                -- Apply Ruff's "Fix All" code action
                vim.lsp.buf.code_action {
                  context = { only = { "source.fixAll" } },
                  apply = true,
                }
              end,
            })
          end
          -- ols specific settings
          if client and client.name == 'ols' then
            -- Perform some actions on save
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = event.buf,
              callback = function()
                -- Format code on save
                vim.lsp.buf.format { async = false, id = event.data.client_id }
              end,
            })
          end
          -- Terraform Language Server specific settings
          if client and client.name == 'terraformls' then
            -- Perform some actions on save
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = event.buf,
              callback = function()
                -- Format code on save
                vim.lsp.buf.format { async = false, id = event.data.client_id }
              end,
            })
          end
        end,
      })
      -- LSP servers and clients are able to communicate to each other what features they support
      -- By default, Neovim doesn't support everything that is in the LSP specification
      -- When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities
      -- So, we create new capabilities with nvim cmp, and then broadcast that to the servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      -- Enable the following language servers
      -- Feel free to add/remove any LSPs that you want here. They will automatically be installed
      -- Add any additional override configuration in the following tables. Available keys are:
      -- - cmd (table): Override the default command used to start the server
      -- - filetypes (table): Override the default list of associated filetypes for the server
      -- - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features
      -- - settings (table): Override the default settings passed when initializing the server
      -- For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- Docker
        dockerls = {
          settings = {
            docker = {
              languageserver = {
                formatter = {
                  ignoreMultilineInstructions = true,
                },
              },
            },
          },
        },
        -- Lua
        lua_ls = {
          -- cmd = { ... },
          -- filetypes = { ... },
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
        -- Odin
        ols = {
          init_options = {
            checker_args = "-strict-style",
            collections = {
              { name = "shared", path = vim.fn.expand('$HOME/odin-lib') }
            },
          },
        },
        -- Python
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = "off"
              }
            }
          }
        },
        ruff = {},
        -- Terraform
        terraformls = {},
        -- YAML
        yamlls = {},
      }
      -- Ensure the servers and tools above are installed
      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run `:Mason`. You can press `g?` for help in this menu
      local ensure_installed = vim.tbl_keys(servers or {})
      -- vim.list_extend(ensure_installed, {
      --   'stylua', -- Used to format Lua code
      -- })
      -- You can add other tools here that you want Mason to install
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }
      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed by the server configuration above
            -- Useful when disabling certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
  {
    -- Optimizes LuaLS for handling Neovim config files
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      { -- Snippet engine & its associated `nvim-cmp` source
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build step is needed for regex support in snippets
          -- This step is not supported in many windows environments
          -- Remove the below condition to re-enable on windows
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets
          -- See the README about individual language/framework/plugin snippets:
          -- - https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
      },
      'saadparwaiz1/cmp_luasnip',
      -- The two depencies below add other completion capabilities
      -- `nvim-cmp` does not ship with all sources by default
      -- They are split into multiple repos for maintenance purposes
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert,noselect' },
        -- For an understanding of why these mappings were chosen,
        -- you will need to read `:help ins-completion`
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          -- Accept ([y]es) the completion
          -- This will auto-import if your LSP supports it
          -- This will expand snippets if the LSP sent a snippet
          -- ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          ['<CR>'] = cmp.mapping.confirm { select = false },
          ['<Tab>'] = nil,
          ['<S-Tab>'] = nil,
          -- ['<Tab>'] = cmp.mapping.select_next_item(),
          -- ['<S-Tab>'] = cmp.mapping.select_prev_item(),

          -- Manually trigger a completion from nvim-cmp
          -- Generally you don't need this, because nvim-cmp will display
          -- completions whenever it has completion options available
          ['<C-Space>'] = cmp.mapping.complete {},
          -- Think of <C-l> as moving to the right of your snippet expansion
          -- So if you have a snippet that's like:
          -- function $name($args)
          --   $body
          -- end
          -- <C-l> will move you to the right of each of the expansion locations
          -- <C-h> is similar, except moving you backwards
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
          -- For more advanced LuaSnip keymaps (e.g. selecting choice nodes, expansion) see:
          -- - https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          {
            name = 'lazydev',
            -- Set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end,
  },
  {
      "kawre/neotab.nvim",
      event = "InsertEnter",
      opts = {
          -- configuration goes here
      },
  },
  -- {
  --   'abecodes/tabout.nvim',
  --   lazy = false,
  --   config = function()
  --     require('tabout').setup {
  --       tabkey = '<Tab>', -- key to trigger tabout, set to an empty string to disable
  --       backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
  --       act_as_tab = true, -- shift content if tab out is not possible
  --       act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
  --       default_tab = '<C-t>', -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
  --       default_shift_tab = '<C-d>', -- reverse shift default action,
  --       enable_backwards = true, -- well ...
  --       completion = false, -- if the tabkey is used in a completion pum
  --       tabouts = {
  --         { open = "'", close = "'" },
  --         { open = '"', close = '"' },
  --         { open = '`', close = '`' },
  --         { open = '(', close = ')' },
  --         { open = '[', close = ']' },
  --         { open = '{', close = '}' }
  --       },
  --       ignore_beginning = false, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
  --       exclude = {} -- tabout will ignore these filetypes
  --     }
  --   end,
  --   dependencies = { -- These are optional
  --     "nvim-treesitter/nvim-treesitter",
  --     "L3MON4D3/LuaSnip",
  --     "hrsh7th/nvim-cmp"
  --   },
  --   opt = false,  -- Set this to true if the plugin is optional
  --   event = 'InsertCharPre', -- Set the event to 'InsertCharPre' for better compatibility
  --   priority = 1000,
  -- },
  -- {
  --   "L3MON4D3/LuaSnip",
  --   keys = function()
  --     -- Disable default tab keybinding in LuaSnip
  --     return {}
  --   end,
  -- },
  { -- Colorscheme
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000, -- Make sure to load this before all the other start plugins
    init = function()
      -- Load the colorscheme here
      vim.cmd.colorscheme 'catppuccin'
      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
    opts = {
      flavour = 'mocha',
      transparent_background = true,
    },
  },
  { -- Autopairs
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    -- Optional dependency
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require('nvim-autopairs').setup {}
      -- If you want to automatically add `(` after selecting a function or method
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp = require 'cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }
      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = {
                'bash', 'c', 'diff', 'hcl', 'html', 'lua', 'luadoc', 'json',
                'markdown', 'markdown_inline','odin', 'python', 'query', 'sql',
                'terraform', 'toml', 'vim', 'vimdoc', 'yaml'
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = { enable = true, },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    -- - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    -- - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    -- - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
})

vim.g.python3_host_prog = '/Users/alexandre/.local/share/pynvim/venv/bin/python3'
