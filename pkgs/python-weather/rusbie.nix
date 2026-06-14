# rusbie — Rust-powered drop-in replacement for Herbie (maturin/PyO3).
# Source: https://github.com/FahrenheitResearch/rusbie
# No Cargo.lock is committed upstream; we vendor a generated one in ./locks.
{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  rustPlatform,
  cargo,
  rustc,
  numpy,
  pandas,
  xarray,
  pyproj,
  requests,
  cfrust,
}:
buildPythonPackage rec {
  pname = "rusbie";
  version = "0.1.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "FahrenheitResearch";
    repo = "rusbie";
    rev = "bd13520b906993d58b1b29d27aaa8aae877a9338";
    hash = "sha256-JscswRq72kWxzzfcNKJU+jQyYL993b0/nFzqSaUAg6c=";
  };

  cargoDeps = rustPlatform.importCargoLock {
    lockFile = ./locks/rusbie.lock;
  };

  # Upstream ships no Cargo.lock; place the vendored one into the source tree
  # so the maturin/cargo build can find it.
  postPatch = ''
    cp ${./locks/rusbie.lock} Cargo.lock
  '';

  nativeBuildInputs = [
    rustPlatform.cargoSetupHook
    rustPlatform.maturinBuildHook
    cargo
    rustc
  ];

  dependencies = [
    numpy
    pandas
    xarray
    pyproj
    # Used at import time in rusbie.core but not declared upstream.
    requests
    cfrust
  ];

  doCheck = false;
  pythonImportsCheck = [ "rusbie" ];

  meta = {
    description = "Drop-in replacement for Herbie powered by Rust — fast NWP data access";
    homepage = "https://github.com/FahrenheitResearch/rusbie";
    license = lib.licenses.mit;
  };
}
