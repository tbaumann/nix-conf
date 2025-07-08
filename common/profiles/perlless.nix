# WARNING: If you enable this profile, you will NOT be able to switch to a new
# configuration and thus you will not be able to rebuild your system with
# nixos-rebuild!
{lib, ...}: {
  # Remove perl from activation
  boot.initrd.systemd.enable = lib.mkDefault true;
  system.etc.overlay.enable = lib.mkDefault true;
  systemd.sysusers.enable = lib.mkDefault true;

  # Random perl remnants
  system.disableInstallerTools = lib.mkDefault true;
  programs.less.lessopen = lib.mkDefault null;
  programs.command-not-found.enable = lib.mkDefault false;
  boot.enableContainers = lib.mkDefault false;
  environment.defaultPackages = lib.mkDefault [];
  documentation.info.enable = lib.mkDefault false;

  # Check that the system does not contain a Nix store path that contains the
  # string "perl".
  #FIXME https://github.com/ryantm/agenix/issues/238
  system.forbiddenDependenciesRegexes = ["perl"];
}
