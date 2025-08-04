{
  config,
  pkgs,
  ...
}: {
  networking.wg-quick.interfaces.secunet-seven = {
    privateKeyFile = config.sops.secrets.secunet-seven-private-key.path;
    address = [
      "198.18.2.11/15"
      "fd00:5ec::20b/48"
    ];
    mtu = 1300;
    peers = [
      {
        allowedIPs = [
          "198.18.0.0/15"
          "fd00:5ec::/48"
        ];
        endpoint = "gateway.seven.secunet.com:51821";
        publicKey = "ZVayNyJeOn848aus5bqYU2ujNxvnYtV3ACoerLtDpg8=";
      }
    ];
  };
  environment.systemPackages = with pkgs; [
    devenv
    fluffychat
    # broken    quaternion
  ];
  nixpkgs.config.permittedInsecurePackages = [
    "fluffychat-linux-1.27.0"
    "olm-3.2.16"
  ];
  nix.settings = {
    substituters = ["http://cache.factory.secunet.com/factory-1"];
    trusted-public-keys = ["factory-1:Ai12PqfDkRmLzju4eE5/ucuDGXw4J31d3aTrz4TZKrk="];
  };
  nix.buildMachines = [
    {
      hostName = "nixbuilder-arm-01.factory.secunet.com";
      protocol = "ssh-ng";
      systems = ["aarch64-linux"];
      maxJobs = 40;
      speedFactor = 2;
      supportedFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
    }
    {
      hostName = "nixbuilder-amd-01.factory.secunet.com";
      protocol = "ssh-ng";
      systems = ["x86_64-linux"];
      maxJobs = 40;
      speedFactor = 2;
      supportedFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
    }
  ];

  programs.ssh.extraConfig = ''
    Host nixbuilder-arm-01.factory.secunet.com
      User nixbuild
      IdentitiesOnly yes
      IdentityFile ${config.sops.secrets.factory-builder-key.path}
    Host nixbuilder-amd-01.factory.secunet.com
      User nixbuild
      IdentitiesOnly yes
      IdentityFile ${config.sops.secrets.factory-builder-key.path}
  '';

  programs.ssh.knownHosts = {
    "nixbuilder-arm-01.factory.secunet.com".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH9NXi+pEIjOcsgh6uIcLxyGAP1pnp87E0T8dBj8wahG";
    "nixbuilder-amd-01.factory.secunet.com".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFZM4vpq5mrih7vS8leIZB1wJok4yVRqVJ30L1euVA45";
  };
}
