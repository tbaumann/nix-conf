{
  programs.nixvim = {
    plugins = {
      schemastore = {
        enable = true;
        yaml.enable = true;
        json.enable = true;
      };
      lsp = {
        enable = true;

        keymaps = {
          silent = true;
          diagnostic = {
            # Navigate in diagnostics
            "<leader>k" = "goto_prev";
            "<leader>j" = "goto_next";
          };

          lspBuf = {
            "<leader>la" = "code_action";
            "<leader>ld" = "definition";
            "<leader>lf" = "format";
            "<leader>lD" = "references";
            "<leader>lt" = "type_definition";
            "<leader>li" = "implementation";
            "<leader>lh" = "hover";
            "<leader>lr" = "rename";
          };
        };

        servers = {
          # broken? tsserver.enable = true;
          clangd.enable = true;
          dockerls.enable = true;
          eslint.enable = true;
          helm_ls.enable = true;
          jsonls.enable = true;
          nil_ls.enable = true;
          nixd.enable = true;
          svelte.enable = true;
          tailwindcss.enable = true;
          terraformls.enable = true;
          yamlls.enable = true;
        };
      };
      which-key.settings.spec = [
        {
          __unkeyed = "<leader>l";
          group = "  LSP";
        }
        {
          __unkeyed = "<leader>la";
          desc = "Code Action";
        }
        {
          __unkeyed = "<leader>ld";
          desc = "Definition";
        }
        {
          __unkeyed = "<leader>lD";
          desc = "References";
        }
        {
          __unkeyed = "<leader>lf";
          desc = "Format";
        }
        {
          __unkeyed = "<leader>lp";
          desc = "Prev";
        }
        {
          __unkeyed = "<leader>ln";
          desc = "Next";
        }
        {
          __unkeyed = "<leader>lt";
          desc = "Type Definition";
        }
        {
          __unkeyed = "<leader>li";
          desc = "Implementation";
        }
        {
          __unkeyed = "<leader>lh";
          desc = "Hover";
        }
        {
          __unkeyed = "<leader>lr";
          desc = "Rename";
        }
      ];
    };
  };
}
