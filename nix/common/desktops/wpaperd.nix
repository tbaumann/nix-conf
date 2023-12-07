{
  pkgs,
  lib,
  ...
}: {
  nixpkgs.overlays = [
    (self: super: {
      wpaperd = super.wpaperd.overrideAttrs (prev: {
        version = "git";
        src = pkgs.fetchFromGitHub {
          owner = "danyspin97";
          repo = "wpaperd";
          rev = "8dd6bf9f92f88efc6cb6862a9c4143c3b02255d7";
          sha256 = "sha256-sQOz9MU2zqczbJpLE8N6PIT4ZrXg4VlNMsJKIVRSm80=";
        };

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
