# wrf-rust — Rust-powered WRF post-processing (maturin/PyO3).
# Source: https://github.com/FahrenheitResearch/wrf-rust
# The crate's default features use the `pure-rust-reader` backend, so no
# system netcdf/HDF5 is required.
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
  pname = "wrf-rust";
  version = "0.2.35";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "FahrenheitResearch";
    repo = "wrf-rust";
    rev = "f05758d9b8ea0132ea8b9767882396cbc5b2cfac";
    hash = "sha256-ofGuaLPn9Qg6tPxugzeb6kOsNTytMgr0INnjimSbv40=";
  };

  cargoDeps = rustPlatform.importCargoLock {
    lockFile = ./locks/wrf-rust.lock;
    outputHashes = {
      # FahrenheitResearch git crates pinned in the lockfile.
      # TODO: fill these in from the first build's "got:" mismatch.
      "ecape-rs-0.1.4" = "sha256-p2LPGRsp+xd1MwalIfsCB+Pgn/FXeRUxMMsNwyRoLWk=";
      "metrust-0.3.9" = "sha256-MncoH+Q2X0ulzv4+N1BVw+CdU5/hx0YPOI1aJnTokJY=";
    };
  };

  nativeBuildInputs = [
    rustPlatform.cargoSetupHook
    rustPlatform.maturinBuildHook
    cargo
    rustc
  ];

  dependencies = [ numpy ];

  doCheck = false;
  # Upstream maps the module to `wrf._wrf`, so the import name is `wrf`.
  pythonImportsCheck = [ "wrf" ];

  meta = {
    description = "Rust-powered WRF post-processing with ECAPE support and 96 diagnostic variables";
    homepage = "https://github.com/FahrenheitResearch/wrf-rust";
    license = lib.licenses.mit;
  };
}
