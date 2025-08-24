{inputs, ...}: {
  imports = [
    inputs.git-hooks-nix.flakeModule
  ];
  perSystem = {
    pre-commit.settings.hooks.nixfmt-rfc-style.enable = true;
  };
}
