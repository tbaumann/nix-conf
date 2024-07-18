{pkgs, ...}: {
  home.packages = with pkgs; [
    erlang
    exercism
    gleam
    rebar3
  ];

  programs.nixvim = {
    plugins.lsp.servers.gleam.enable = true;
  };
}
