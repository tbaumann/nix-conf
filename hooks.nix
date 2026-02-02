{ inputs, ... }:
{
  imports = [
    inputs.git-hooks-nix.flakeModule
  ];
  perSystem = {
    pre-commit.settings.hooks.nixfmt-rfc-style.enable = true;
    treefmt.programs = {
      statix = {
        enable = true;
        disabled-lints = [
          "empty_pattern"
          "redundant_pattern_bind"
          "unquoted_splice"
        ];
      };
      deadnix.enable = false; # # Not yet
      nixfmt.enable = true;
    };
  };
}
