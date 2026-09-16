{
  pkgs,
  inputs,
  ...
}:
{
  imports = [ inputs.omp.homeManagerModules.default ];
  home.packages =
    with pkgs;
    with inputs;
    [
      llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.kilocode-cli
      llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.pi
      llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.rtk
      poppler-utils
      wl-clipboard # Opencode uses it
    ];
  programs.omp = {
    enable = true;
    #settings.startup.quiet = true;
  };
}
