# rustplots — Rust-powered meteorology plotting, drop-in for metpy.plots
# (maturin/PyO3). Source: https://github.com/FahrenheitResearch/rustplots
# No Cargo.lock is committed upstream; we vendor a generated one in ./locks.
{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  rustPlatform,
  cargo,
  rustc,
  numpy,
}:
buildPythonPackage rec {
  pname = "rustplots";
  version = "0.1.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "FahrenheitResearch";
    repo = "rustplots";
    rev = "e1ea1d03b96fa9986b6b040e80949b742ce289d6";
    hash = "sha256-NX1YncvB/DNtW2bozo6XX2SGtpXNdsykwX6/tZ3nHh8=";
  };

  cargoDeps = rustPlatform.importCargoLock {
    lockFile = ./locks/rustplots.lock;
  };

  # Upstream ships no Cargo.lock; place the vendored one into the source tree
  # so the maturin/cargo build can find it.
  postPatch = ''
    cp ${./locks/rustplots.lock} Cargo.lock
  '';

  nativeBuildInputs = [
    rustPlatform.cargoSetupHook
    rustPlatform.maturinBuildHook
    cargo
    rustc
  ];

  dependencies = [ numpy ];

  doCheck = false;
  pythonImportsCheck = [ "rustplots" ];

  meta = {
    description = "Rust-powered meteorology plotting. Drop-in for metpy.plots.";
    homepage = "https://github.com/FahrenheitResearch/rustplots";
    license = lib.licenses.mit;
  };
}
