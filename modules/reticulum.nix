{inputs, ...}: {
  imports = with inputs; [
    # Essential packages (always include)
    reticulum-flake.nixosModules.sine-qua-non-packages

    # Complete Reticulum ecosystem
    reticulum-flake.nixosModules.reticulum-integration
    reticulum-flake.nixosModules.local-tools-integration

    # Optional: GNOME menu entries
    reticulum-flake.nixosModules.meshchat-launchers

    # Use packages overlay
    {nixpkgs.overlays = [reticulum-flake.overlays.default];}
  ];
}
