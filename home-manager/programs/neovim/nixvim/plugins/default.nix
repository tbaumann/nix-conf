{pkgs, ...}: {
  imports = [
    #./lualine.nix
    ./airline.nix
    ./auto-session.nix
    ./barbar.nix
    ./comment.nix
    ./efm.nix
    ./floaterm.nix
    ./harpoon.nix
    ./lsp.nix
    ./markdown-preview.nix
    ./neo-tree.nix
    ./neorg.nix
    #    ./startify.nix
    ./tagbar.nix
    ./telescope.nix
    ./treesitter.nix
  ];

  programs.nixvim = {
    #    colorschemes.gruvbox.enable = true;

    # Plugins that don't have a NixVim plugin module yet (2024-02-10)
    # Check from time to time if they have been added to the list of plugins
    extraPlugins = with pkgs.vimPlugins; [
      # Run tests with keystrokes
      vim-test

      # Read .editorconfig file and override default Vim settings
      editorconfig-nvim
    ];

    plugins = {
      #      auto-session.enable = true;
      commentary.enable = true;
      /*
      copilot-lua.enable = true;
      copilot-lua.panel.enabled = false;
      copilot-lua.suggestion.enabled = false;
      */
      coverage.enable = true;
      cursorline.enable = true;
      #      dashboard.enable = false;
      gitsigns = {
        enable = true;
        settings = {
          signs = {
            add.text = "+";
            change.text = "~";
          };
        };
      };

      nvim-autopairs.enable = true;

      nvim-colorizer = {
        enable = true;
        userDefaultOptions.names = false;
      };
      illuminate.enable = true;
      lastplace.enable = true;
      oil.enable = true;
      vim-surround.enable = true;
      which-key.enable = true;
      #icons
      web-devicons.enable = true;
    };
  };
}
