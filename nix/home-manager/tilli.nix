{
  inputs,
  pkgs,
  config,
  age,
  ...
}: {
  imports = [
    ./tilli
  ];

  age.secrets = {
    vpn-password = {
      file = ../secrets/vpn-password.age;
    };
  };
  home = {
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    username = "tilli";
    homeDirectory = "/home/tilli";

    packages = with pkgs; [
      cloak
      openvpn
    ];
  };
  programs.git.enable = true;
  programs.git.userEmail = "tilman@baumann.name";
  programs.git.userName = "Tilman Baumann";

  /*
  # Default desktop environment
  xsession = {
    enable = true;
    windowManager.command = "Hyprland";
  };

    programs.thunderbird.enable = true;
    programs.thunderbird.profiles =
    {
      "defo" = {
        name = "defo";
        isDefault = true;
        settings = {
          "mail.spellcheck.inline" = false;
        };
      };
    };
    accounts.email.accounts = {
      name = {
        address = "tilman.baumann@tilman.baumann.name";
        primary = true;
        realName = "Tilman Baumann";
        imap.host = "imap.migadu.com";
        smtp.host = "smtp.migadu.com";
        userName = "tilman.baumann@tilman.baumann.name";
  #      thunderbird.enable = true;
  #      thunderbird.profiles = ["def"];
      };
    };
  */
}
