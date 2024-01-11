{pkgs, ...}: {
  imports = [
    ./autocommands.nix
    ./completion.nix
    ./keymappings.nix
    ./options.nix
    ./plugins
    ./todo.nix
  ];

  stylix.targets.nixvim.enable = false;
  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin.enable = true;
    defaultEditor = true;

    vimAlias = true;

    luaLoader.enable = true;

    # Highlight and remove extra white spaces
    highlight.ExtraWhitespace.bg = "red";
    match.ExtraWhitespace = "\\s\\+$";

    extraPlugins = with pkgs.vimPlugins; [
      yanky-nvim
      tint-nvim
      sort-nvim
    ];
  };
}
