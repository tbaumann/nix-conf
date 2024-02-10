{
  pkgs,
  lib,
  ...
}: {
  # environment.systemPackages = [inputs.wpaperd.pkgs.wpaperd];
  nixpkgs.overlays = [
    (self: super: {
      wpaperd = super.wpaperd.overrideAttrs (prev: {
        version = "git";
        src = pkgs.fetchFromGitHub {
          owner = "danyspin97";
          repo = "wpaperd";
          rev = "0975ea1a7c39e37b892723a195bee5837ad18c06";
          sha256 = "sha256-4PldAwekCfOgFdz0DUvOp9pALMMlvy54dzwDMJRGVZE=";
        };
        buildInputs = (prev.buildInputs or []) ++ [pkgs.wayland pkgs.wayland-protocols pkgs.wlr-protocols pkgs.glfw-wayland];

        cargoDeps = super.rustPlatform.importCargoLock {
          lockFile = ./Cargo.lock;
        };
        postPatch = ''
          rm Cargo.lock
          ln -s ${./Cargo.lock} Cargo.lock
        '';
      });
    })
  ];
}
