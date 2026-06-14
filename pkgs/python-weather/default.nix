# Python package set extension providing the FahrenheitResearch Rust-backed
# weather stack plus the hermes weather plugin that consumes it.
#
# Returns an overlay for `pythonPackagesExtensions` so every package can refer
# to the others (e.g. rusbie -> cfrust) via the normal `python3Packages` set.
#
# Usage (in pkgs.nix overlay):
#   pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
#     (import ./pkgs/python-weather/default.nix)
#   ];
final: _prev: {
  metrust = final.callPackage ./metrust.nix { };
  cfrust = final.callPackage ./cfrust.nix { };
  rustplots = final.callPackage ./rustplots.nix { };
  wrf-rust = final.callPackage ./wrf-rust.nix { };
  rusbie = final.callPackage ./rusbie.nix { };
  rustweather = final.callPackage ./rustweather.nix { };
  hermes-weather-plugin = final.callPackage ./hermes-weather-plugin.nix { };
}
