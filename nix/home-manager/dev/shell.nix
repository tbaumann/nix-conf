{
  programs = {
    nixvim = {
      plugins = {
        efmls-configs.setup = let
          shellTools = {
            formatter = "shfmt";
            linter = "shellcheck";
          };
        in {
          bash = shellTools;
          sh = shellTools;
          fish .formatter = "fish_indent";
          fish.linter = "fish";
        };

        lsp.servers = {
          bashls.enable = true;

          efm.filetypes = [
            "bash"
            "sh"
            "fish"
          ];
        };
      };
    };
  };
}
