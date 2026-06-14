# metrust — Rust-powered MetPy-compatible calculation layer (maturin/PyO3).
# Source: https://github.com/FahrenheitResearch/metrust-py
{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  rustPlatform,
  cargo,
  rustc,
  numpy,
  pint,
}:
buildPythonPackage rec {
  pname = "metrust";
  version = "0.4.7";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "FahrenheitResearch";
    repo = "metrust-py";
    rev = "a1664c245051c363a9fc2462d6ed1f2596a21e02";
    hash = "sha256-YF7o+xwzLK60ewEwfny6WJjFP6iPqIFgCnlRafrb0yk=";
  };

  cargoDeps = rustPlatform.importCargoLock {
    lockFile = ./locks/metrust.lock;
    outputHashes = {
      # FahrenheitResearch git crates pinned in the lockfile.
      # TODO: fill these in from the first build's "got:" mismatch.
      "ecape-rs-0.1.4" = "sha256-2J5GGFUfpqUl1iwKBFz/ix0UBeA6hvjElSXiODuBX/I=";
      "metrust-0.3.9" = "sha256-MncoH+Q2X0ulzv4+N1BVw+CdU5/hx0YPOI1aJnTokJY=";
    };
  };

  nativeBuildInputs = [
    rustPlatform.cargoSetupHook
    rustPlatform.maturinBuildHook
    cargo
    rustc
  ];

  dependencies = [
    numpy
    pint
  ];

  # Rust extension module; no Python tests wired up here.
  doCheck = false;
  pythonImportsCheck = [ "metrust" ];

  meta = {
    description = "Rust-powered MetPy-compatible calculation layer with optional GPU acceleration";
    homepage = "https://github.com/FahrenheitResearch/metrust-py";
    license = lib.licenses.mit;
  };
}
