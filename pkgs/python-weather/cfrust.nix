# cfrust — Rust-powered drop-in replacement for cfgrib (maturin/PyO3).
# Source: https://github.com/FahrenheitResearch/cfrust
# No Cargo.lock is committed upstream; we vendor a generated one in ./locks.
{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  rustPlatform,
  cargo,
  rustc,
  numpy,
  attrs,
}:
buildPythonPackage rec {
  pname = "cfrust";
  version = "0.1.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "FahrenheitResearch";
    repo = "cfrust";
    rev = "d326eca4615df9cb3b081181e5e56a9026bb7c3f";
    hash = "sha256-Ut5bXuo1fLbwdEfmeYyhbaLLVBt/9XWSSjTxRZFZf+o=";
  };

  cargoDeps = rustPlatform.importCargoLock {
    lockFile = ./locks/cfrust.lock;
  };

  # Upstream ships no Cargo.lock; place the vendored one into the source tree
  # so the maturin/cargo build can find it.
  postPatch = ''
    cp ${./locks/cfrust.lock} Cargo.lock
  '';

  nativeBuildInputs = [
    rustPlatform.cargoSetupHook
    rustPlatform.maturinBuildHook
    cargo
    rustc
  ];

  dependencies = [
    numpy
    attrs
  ];

  doCheck = false;
  pythonImportsCheck = [ "cfrust" ];

  meta = {
    description = "Drop-in replacement for cfgrib powered by Rust";
    homepage = "https://github.com/FahrenheitResearch/cfrust";
    license = lib.licenses.mit;
  };
}
