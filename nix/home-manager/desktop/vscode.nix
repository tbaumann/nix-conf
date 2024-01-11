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
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;
    mutableExtensionsDir = true;
    extensions = with pkgs.vscode-extensions; [
      github.copilot
      vscodevim.vim
      catppuccin.catppuccin-vsc
      jnoortheen.nix-ide
      maximedenes.vscoq
      mkhl.direnv
      yzhang.markdown-all-in-one # Recommended by Foam
      github.codespaces
      github.copilot
      ms-python.vscode-pylance
      ms-vscode-remote.remote-ssh
      #ejgallego.coq-lsp
      github.copilot-chat
    ];
    userSettings = {
      "editor.inlineSuggest.enabled" = true; # Copilot
      "github.copilot.enable" = {
        "*" = true;
        plaintext = true;
        markdown = true;
        scminput = false;
        yaml = true;
      };
      "extensions.autoUpdate" = false;
    };
  };
}
