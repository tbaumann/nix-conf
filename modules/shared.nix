 config, clan-core, ... }:
{
  imports = [
    # Enables the OpenSSH server for remote access
    clan-core.clanModules.sshd
    # Set a root password
    clan-core.clanModules.root-password
    clan-core.clanModules.state-version

    ../common/user-group.nix
    ../common/core.nix
  ];

  # Locale service discovery and mDNS
  services.avahi.enable = true;


}

