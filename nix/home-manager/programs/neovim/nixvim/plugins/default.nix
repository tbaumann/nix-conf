{
  imports = [
    ./airline.nix
    ./barbar.nix
    ./comment.nix
    ./efm.nix
    ./floaterm.nix
    ./harpoon.nix
    ./lsp.nix
    ./lualine.nix
    ./markdown-preview.nix
    ./neorg.nix
    ./neo-tree.nix
    ./startify.nix
    ./tagbar.nix
    ./telescope.nix
    ./treesitter.nix
  ];

  programs.nixvim = {
    #    colorschemes.gruvbox.enable = true;

    plugins = {
      copilot-lua.enable = true;
      copilot-lua.panel.enabled = false;
      copilot-lua.suggestion.enabled = false;
      gitsigns = {
        enable = true;
        signs = {
          add.text = "+";
          change.text = "~";
        };
      };

      nvim-autopairs.enable = true;

      nvim-colorizer = {
        enable = true;
        userDefaultOptions.names = false;
      };
      coverage.enable = true;
      cursorline.enable = true;
      dashboard.enable = true;
      illuminate.enable = true;
      image.enable = true;
      which-key.enable = true;
      oil.enable = true;
    };
  };
}
