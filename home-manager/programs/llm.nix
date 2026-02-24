{
  pkgs,
  inputs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.goose-cli
    poppler-utils
    wl-clipboard # Opencode uses it
  ];
  programs.opencode = {
    enable = true;
    package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode;
  };
}
