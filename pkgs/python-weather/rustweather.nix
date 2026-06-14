# rustweather — pure-Python umbrella wrapper tying the Rust-backed weather
# stack together (setuptools, no Rust build of its own).
# Source: https://github.com/FahrenheitResearch/rustweather
{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  numpy,
  pandas,
  xarray,
  matplotlib,
  pyproj,
  cfrust,
  rusbie,
  metrust,
  rustplots,
}:
buildPythonPackage rec {
  pname = "rustweather";
  version = "0.1.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "FahrenheitResearch";
    repo = "rustweather";
    rev = "2da56999b732dce35c4976fd4ca72fecb7ca9287";
    hash = "sha256-KlEGvHaPoxRjV540QCSDtQs0jZi8eUZ9VTpW32Mt3us=";
  };

  build-system = [ setuptools ];

  dependencies = [
    numpy
    pandas
    xarray
    matplotlib
    pyproj
    cfrust
    rusbie
    metrust
    rustplots
  ];

  doCheck = false;
  pythonImportsCheck = [ "rustweather" ];

  meta = {
    description = "One install. One line. Every weather workflow. Powered by Rust.";
    homepage = "https://github.com/FahrenheitResearch/rustweather";
    license = lib.licenses.mit;
  };
}
