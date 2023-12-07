{
  inputs,
  pkgs,
  ...
}: {
  # add the overlay:
  nixpkgs.overlays = [
    # catppuccin theme
    inputs.catppuccin-vsc.overlays.default

    #override electron engine
    # https://github.com/NixOS/nixpkgs/issues/263764#issuecomment-1782979513
    (final: prev: {
      vscode = prev.vscode.override {
        electron = final.electron_24;
      };
    })
  ];
  # In config
  #nixpkgs.config.permittedInsecurePackages = [ "electron-24.8.6" ];
  #environment.systemPackages = with pkgs; [ obsidian-wayland ];

  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
    extensions = with pkgs; [
      vscode-extensions.github.copilot
      vscode-extensions.vscodevim.vim
      vscode-extensions.catppuccin.catppuccin-vsc
    ];
  };
}
