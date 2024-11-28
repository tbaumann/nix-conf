{config, ...}: {
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;

      nixvimInjections = true;

      folding = true;
      settings.indent.enable = true;

      /*
      grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
        bash
        c
        html
        javascript
        typescript
        lua
        nix
        norg
        python
        rust
        vimdoc
      ];
      */
    };

    treesitter-refactor = {
      enable = true;
      highlightDefinitions.enable = true;
    };
  };
}
