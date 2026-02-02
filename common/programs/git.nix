{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    package = pkgs.gitMinimal;
    config = {
      core = {
        pager = "${pkgs.delta}/bin/delta";
      };
      interactive = {
        diffFilter = "${pkgs.delta}/bin/delta --color-only";
      };
      extraConfig = {
        color.ui = true;
        core.editor = "nvim";
        blame.date = "relative";
        pull = {
          rebase = false;
        };
        diff = {
          colorMoved = "default";
        };
        push = {
          autoSetupRemote = true;
        };
      };
      # difftastic = {
      #   enable = true;
      #   display = "inline";
      # };
      merge = {
        conflictstyle = "diff3";
      };
      diff = {
        colorMoved = "default";
      };
      lfs.enable = false;
      delta = {
        enable = true;
        options = {
          light = false;
          navigate = true;
          side-by-side = true;
          features = "decorations";
          syntax-theme = "gruvbox-dark";
        };
      };
    };
  };
  environment.systemPackages = with pkgs; [
    gist
  ];
}
