{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = [pkgs.obsidian];
  programs.nixvim.plugins.obsidian = {
    enable = true;
    settings.workspaces = [
      {
        name = "Obsidian Vault";
        path = "~/Documents/Obsidian Vault/";
      }
    ];
  };
}
