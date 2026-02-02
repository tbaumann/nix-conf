{
  lib,
  pkgs,
  ...
}:
{
  home.packages = [
    (
      let
        pname = "ente";
        version = "1.7.8";

        src = pkgs.fetchurl {
          url = "https://github.com/ente-io/photos-desktop/releases/download/v${version}/${pname}-${version}-x86_64.AppImage";
          hash = "sha256-cYq9YEybQsssOor/lN1k6/OVnO5l6HQgdzpFuw24q08=";
        };
      in
      pkgs.appimageTools.wrapType2 {
        pname = "ente-io";
        inherit version src;
      }
    )
  ];
}
