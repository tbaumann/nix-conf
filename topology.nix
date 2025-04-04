{inputs, ...}: {
  imports = [
    inputs.nix-topology.flakeModule
  ];

  perSystem = {system, ...}: {
    topology.pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = [inputs.nix-topology.overlays.default];
    };
    topology.modules = [
      {
        # Inline module to inform topology of your existing NixOS hosts.
        networks.home = {
          name = "Home";
          cidrv4 = "192.168.1.0/24";
        };
      }
    ];
  };
}
