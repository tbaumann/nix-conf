# hermes-weather-plugin — Hermes Agent weather plugin (model imagery, radar,
# soundings, ECAPE). Source: https://github.com/FahrenheitResearch/hermes-weather-plugin
#
# Version is read straight from the upstream pyproject.toml so it never needs
# to be maintained by hand here.
{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  requests,
  numpy,
  metrust,
  cfrust,
  rusbie,
  rustweather,
  wrf-rust,
}:
let
  src = fetchFromGitHub {
    owner = "FahrenheitResearch";
    repo = "hermes-weather-plugin";
    rev = "d474493ef4ffeefabad9dbf0188f72bce3b47b67";
    hash = "sha256-VY42TBTzDFpPZ+6TgoB5QAbOjaurIh32TUG2/vV4FOk=";
  };
  pyproject = builtins.fromTOML (builtins.readFile "${src}/pyproject.toml");
in
buildPythonPackage {
  pname = "hermes-weather-plugin";
  inherit (pyproject.project) version;
  inherit src;
  pyproject = true;

  build-system = [ setuptools ];

  dependencies = [
    requests
    numpy
    metrust
    cfrust
    rusbie
    rustweather
    wrf-rust
  ];

  # Plugin loaded as a hermes-agent plugin directory; no standalone test suite.
  doCheck = false;

  meta = {
    description = "Hermes Agent weather plugin with model imagery, radar, soundings, and ECAPE";
    homepage = "https://github.com/FahrenheitResearch/hermes-weather-plugin";
    license = lib.licenses.mit;
  };
}
