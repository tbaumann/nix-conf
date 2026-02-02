{
  pkgs,
  ...
}:
{
  #nixpkgs.config.permittedInsecurePackages = [ "electron-24.8.6" ];
  #environment.systemPackages = with pkgs; [ obsidian-wayland ];
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

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
