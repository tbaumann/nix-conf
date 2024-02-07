{
  programs.nixvim = {
    options.completeopt = ["menu" "menuone" "noselect"];

    plugins = {
      #      luasnip.enable = true;

      lspkind = {
        enable = false;

        cmp = {
          enable = true;
          menu = {
            nvim_lsp = "[LSP]";
            #            nvim_lua = "[api]";
            path = "[path]";
            buffer = "[buffer]";
            #            neorg = "[neorg]";
            calc = "[calc]";
            clippy = "[clippy]";
            #cmp_tabnine = "[TabNine]";
            # FXME maybe more here?
          };
        };
      };

      nvim-cmp = {
        enable = true;

        #    snippet.expand = "luasnip";
        completion.keywordLength = 2;

        mapping = {
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.close()";
          "<Tab>" = {
            modes = ["i" "s"];
            action = "cmp.mapping.select_next_item()";
          };
          "<S-Tab>" = {
            modes = ["i" "s"];
            action = "cmp.mapping.select_prev_item()";
          };
          "<CR>" = "cmp.mapping.confirm({ select = true })";
        };

        sources = [
          {name = "path";}
          {name = "nvim_lsp";}
          /*
                   #          {name = "cmp_tabnine";}
                   {
                     name = "buffer";
                     # Words from other open buffers can also be suggested.
                     option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
                   }
          #         {name = "neorg";}
                   {name = "copilot";}
                   {name = "calc";}
                   {name = "clippy";}
                   {name = "cmdline";}
                   {name = "fuzzy-path";}
                   {name = "fish";}
          */
        ];
      };
    };
  };
}
