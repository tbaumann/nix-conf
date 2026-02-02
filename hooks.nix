{...}: {
  imports = [
  ];
  perSystem = {
    pre-commit.settings.enable = true;
    pre-commit.settings.hooks.treefmt.enable = true;
    treefmt.programs = {
      statix = {
        enable = true;
        disabled-lints = [
          "empty_pattern"
          "redundant_pattern_bind"
          "unquoted_splice"
        ];
      };
      deadnix.enable = true;
      nixfmt.enable = true;
    };
  };
}
