{
  programs.nixvim = {
    opts.completeopt = ["menu" "menuone" "noselect"];

    plugins = {
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          completion.keyword_length = 2;
          sources = [
            {name = "nvim_lsp";}
            {name = "copilot-cmp";}
            {name = "path";}
            {
              name = "buffer";
              option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
            }
          ];
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-e>" = "cmp.mapping.close()";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          };
          preselect = "cmp.PreselectMode.None";
        };
      };

      lspkind = {
        enable = false;
        mode = "symbol_text";

        cmp = {
          enable = true;
        };
      };
    };
  };
}
