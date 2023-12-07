{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
  ];

  programs = {
    direnv.enable = true;
    #    git.enable = true;
    npm.enable = true;
    less.enable = true;
    fish.enable = true;
    #    openvpn3.enable = true;
    #     neovim.enable = true;
  };
  services = {
    boinc.enable = true;
  };
  environment.systemPackages = with pkgs; [
    openvpn
    update-systemd-resolved
    inotify-tools
    libnotify
    s5cmd
  ];
}
