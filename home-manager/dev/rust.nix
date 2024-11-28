{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    bacon
    cargo
    gcc
    rustc
    rustfmt
  ];

  programs.nixvim = {
    plugins = {
      lsp-format.lspServersToEnable = ["rust_analyzer"];
      lsp.servers = {
        rust_analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
          settings = {
            cargo.features = "all";
          };
        };
      };
    };
  };
}
