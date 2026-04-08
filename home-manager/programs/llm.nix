{
  pkgs,
  inputs,
  config,
  ...
}: {
  home.packages = with pkgs;
  with inputs; [
    llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.goose-cli
    llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.kilocode-cli
    llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.pi
    llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.rtk
    poppler-utils
    wl-clipboard # Opencode uses it
  ];
  programs.opencode = {
    enable = true;
    package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode;
  };
}
