{
  pkgs,
  inputs,
  ...
}:
{
  home.packages = with pkgs; [
    inputs.llm-agents.packages.${pkgs.system}.goose-cli
    poppler-utils
    wl-clipboard # Opencode uses it
  ];
  programs.opencode = {
    enable = true;
    package = inputs.llm-agents.packages.${pkgs.system}.opencode;
  };
}
