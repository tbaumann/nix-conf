{pkgs, ...}: {
  programs.git.enable = true;
  programs.git.config = {
    core = {
      pager = "${pkgs.delta}/bin/delta";
    };
    interactive = {
      diffFilter = "${pkgs.delta}/bin/delta --color-only";
    };
    delta = {
      navigate = true;
      side-by-side = true;
      line-numbers = true;
    };
    merge = {
      conflictstyle = "diff3";
    };
    diff = {
      colorMoved = "default";
    };
  };
  environment.systemPackages = with pkgs; [
    gist
  ];
}
