return {
  { -- Configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  { -- Main LSP Configuration
    "neovim/nvim-lspconfig",
    dependencies = {},
    config = function()
      --  This function gets run when an LSP attaches to a particular buffer
      --  That is to say, every time a new file is opened that is associated with
      --    an lsp (e.g., opening `main.rs` is associated with `rust_analyzer`)
      --    this function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          --   to define small helper and utility functions so you don"t have to repeat yourself
          --   In this case, we create a function that lets us more easily define mappings specific
          --   for LSP related items. It sets the mode, buffer and description for us each time
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          -- Rename the variable under your cursor
          -- Most Language Servers support renaming across files, etc
          map("grn", vim.lsp.buf.rename, "[R]e[n]ame")

          -- Execute a code action, usually your cursor needs to be on top of an error
          --  or a suggestion from your LSP for this to activate.
          map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

          -- WARN: This is not Goto Definition, this is Goto Declaration
          --  For example, in C this would take you to the header
          map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            return client:supports_method(method, bufnr)
          end

          -- The following two autocommands are used to highlight references of the
          --  word under your cursor when your cursor rests there for a little while
          -- See `:help CursorHold` for information about when this is executed
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })

            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            -- When you move your cursor, the highlights will be cleared
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
              callback = function(event_detach)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = "kickstart-lsp-highlight", buffer = event_detach.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          --  code, if the language server you are using supports them
          -- This may be unwanted, since they displace some of your code
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map("<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, "[T]oggle Inlay [H]ints")
          end

          -- Clangd specific settings
          if client and client.name == "clangd" then
            -- Perform some actions on save
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = event.buf,
              callback = function()
                -- Format code on save
                vim.lsp.buf.format { async = false, id = event.data.client_id }
              end,
            })
          end

          -- Ruff specific settings
          if client and client.name == "ruff" then
            -- Perform some actions on save
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = event.buf,
              callback = function()
                -- Format code on save
                vim.lsp.buf.format { async = false, id = event.data.client_id }
                -- Apply ruff's "Fix All" code action
                vim.lsp.buf.code_action {
                  ---@diagnostic disable-next-line: missing-fields 
                  context = { only = { "source.fixAll" } },
                  apply = true,
                }
              end,
            })
          end

          -- Terraform language server specific settings
          if client and client.name == "terraformls" then
            -- Perform some actions on save
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = event.buf,
              callback = function()
                -- Format code on save
                vim.lsp.buf.format { async = false, id = event.data.client_id }
              end,
            })
          end

        end,
      })

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
          },
        } or {},
        virtual_text = {
          source = "if_many",
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      -- Enable the following language servers
      -- Feel free to add/remove any LSPs that you want here. They will automatically be installed
      -- Add any additional override configuration in the following tables. Available keys are:
      --   - cmd (table): Override the default command used to start the server
      --   - filetypes (table): Override the default list of associated filetypes for the server
      --   - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features
      --   - settings (table): Override the default settings passed when initializing the server
      -- For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- Bash
        bashls = {},

        -- C & C++
        clangd = {},

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

        -- Go
        gopls = {},

        -- Lua
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
              -- You can toggle below to ignore Lua_LS"s noisy `missing-fields` warnings
              diagnostics = { disable = { "missing-fields" } },
            },
          },
        },

        -- JSON
        jsonls = {
          json = {
            validate = { enable = true },
          },
        },

        -- Odin
        ols = {},

        -- Python
        ruff = {},
        ty = {},

        -- Terraform
        terraformls = {},

        -- YAML
        yamlls = {
          yaml = {
            schemaStore = { enable = false },
            validate = true,
          },
        },
      }

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      for server_name, server in pairs(servers) do
        server.capabilities = vim.tbl_deep_extend(
          "force",
          {},
          capabilities,
          server.capabilities or {}
        )
        vim.lsp.config(server_name, server)
        vim.lsp.enable(server_name)
      end
    end,
  },
}
