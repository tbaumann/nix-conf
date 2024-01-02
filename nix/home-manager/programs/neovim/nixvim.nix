{
  inputs,
  pkgs,
  ...
}:
{
  programs.nixvim = {
    enable = true;
    vimAlias = true;
#    colorschemes.catppuccin.enable = true;
    clipboard.providers.wl-copy.enable = true;
    clipboard.register = "unnamedplus";
    options = {
      number = true;
      relativenumber = true;
      softtabstop = 2;
      tabstop = 2; # num of space characters per tab
      shiftwidth = 2; # spaces per indentation level
      expandtab = true; # expand tab input with spaces characters
      smartindent = true; # syntax aware indentations for newline inserts
      mouse = "a";

    };
    extraPlugins = with pkgs.vimPlugins; [
      yanky-nvim
    ];
    plugins = {
      telescope.enable = true;
      telescope.extensions.file_browser.enable = true;
      airline.enable = true;
      airline.powerline = true;
      coq-nvim.enable = true;
      dashboard.enable = true;
      lsp-format.enable = true;
      copilot-cmp.enable = true;
      cmp-clippy.enable = true;
      cmp-vim-lsp.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-cmdline.enable = true;
      treesitter.enable = true;
      which-key.enable = true;
      todo-comments.enable = true;
      lsp = {
        enable = true;
        keymaps = {
          silent = true;
          diagnostic = {
            "<leader>k" = "goto_prev";
            "<leader>j" = "goto_next";
          };

          lspBuf = {
            gd = "definition";
            K = "hover";
          };
        };
        servers = {
          bashls.enable = true;
          clangd.enable = true;
          nil_ls.enable = true;
          eslint.enable = true;
          nixd.enable = true;
          yamlls.enable = true;
        };
      };
    };
    keymaps = [
      {
        key = "Y";
        action = "yy";
        mode = "n";
        options = {
          desc = "Yank line";
        };
      }
      {
        key = "<C-s>";
        action = ":w!<cr>";
        mode = "n";
        options = {
          desc = "Save File";
        };
      }
    ];

  };
  home = {
    packages = with pkgs; [
      #-- nix
      nil
      rnix-lsp
      # nixd
      statix # Lints and suggestions for the nix programming language
      deadnix # Find and remove unused code in .nix source files
      alejandra # Nix Code Formatter

      #-- bash
      nodePackages.bash-language-server
      shellcheck
      shfmt

      #-- Misc
      tree-sitter # common language parser/highlighter
      nodePackages.prettier # common code formatter
      marksman # language server for markdown
      glow # markdown previewer

      #-- Optional Requirements:
      gdu # disk usage analyzer, required by AstroNvim
      ripgrep # fast search tool, required by AstroNvim's '<leader>fw'(<leader> is space key)
    ];
  };
}
