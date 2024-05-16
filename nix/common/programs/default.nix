{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./kicad.nix
    #     ./nh.nix FIXME add back when it's in stable
    ./nix-alien.nix
    ./git.nix
  ];

  programs = {
    #    git.enable = true;
    direnv.enable = true;
    fish.enable = true;
    less.enable = true;
    nix-ld.enable = true;
    npm.enable = true;
    steam.enable = false;
  };
  stylix.targets.fish.enable = false;
  services = {
    boinc.enable = false;
  };
  environment.systemPackages = with pkgs; [
    openvpn
    update-systemd-resolved
    inotify-tools
    libnotify
    s5cmd
    spice
    spice-gtk
    localsend
    fh
    pv
    just
  ];
}
