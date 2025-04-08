{inputs, ...}: {
  imports = with inputs; [
    ../../modules/shared.nix
    ../../hosts/zuse-klappi/default.nix
  ];
}
