{ pkgs, lib, ... }: {
  imports = [
  ];

  home = {
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    username = "tbaumann";
    homeDirectory = "/home/tbaumann";

    packages = with pkgs; [
      cloak
      qmk
    ];
  };
  programs.git.enable = true;

  ## Don't clobber everything from Ubuntu
  programs.ssh.enable = lib.mkForce false;
  xdg.enable = lib.mkForce false;
  xdg.userDirs.enable = lib.mkForce false;
}
