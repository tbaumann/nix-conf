{ pkgs, ... }: {
  imports = [
    ./tilli
  ];

  home = {
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    username = "tilli";
    homeDirectory = "/home/tilli";

    packages = with pkgs; [
      cloak
      qmk
    ];
  };
  programs.git.enable = true;
  programs.git.settings = {
    user = {
      email = "tilman@baumann.name";
      name = "Tilman Baumann";
    };
    aliases = {
      pr = "pull --rebase";
    };
    push.autoSetupRemote = true;
    init.defaultBranch = "main";
  };
  home.file.".face" = {
    source = ./tilli/tilli-face.png;
  };
}
