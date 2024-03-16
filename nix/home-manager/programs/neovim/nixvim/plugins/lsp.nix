{
  programs.nixvim = {
    plugins = {
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
            gd = "definition";
            gD = "references";
            gt = "type_definition";
            gi = "implementation";
            K = "hover";
            "<F2>" = "rename";
          };
        };

        servers = {
          bashls.enable = true;
          clangd.enable = true;
          dockerls.enable = true;
          eslint.enable = true;
          lua-ls.enable = true;
          nil_ls.enable = true;
          nixd.enable = true;
          svelte.enable = true;
          tailwindcss.enable = true;
          tsserver.enable = true;
          yamlls.enable = true;
        };
      };
    };
  };
}
