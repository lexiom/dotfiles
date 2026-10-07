{ pkgs, ... }:

{
  xdg.configFile = {
    "nvim/lua/plugins/ai.lua".text = ''
      return {
        {
          "olimorris/codecompanion.nvim",
          dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
          },
          opts = {
            adapters = {
              acp = {
                extend = {
                  cursor_cli = {
                    defaults = {
                      session_config_options = {
                        model = "grok-4.7-high",
                      },
                    },
                  },
                },
              },
            },
            interactions = {
              chat = {
                adapter = "cursor_cli",
              },
            },
            display = {
              chat = {
                window = {
                  layout = "buffer",
                },
              },
            },
          },
        },
      }
    '';
  };
}
