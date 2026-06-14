{
  lib,
  fetchFromGitHub,
  rustPlatform,
  makeWrapper,
  openssl,
  pkg-config,
  onnxruntime,
  onnx,
}:
rustPlatform.buildRustPackage rec {
  pname = "icm";
  version = "0.10.50";

  src = fetchFromGitHub {
    owner = "rtk-ai";
    repo = "icm";
    rev = "${pname}-v${version}";
    hash = "sha256-zaKpKMVH2vzUk0ryWupE4ByqqcmAdJwAe5ybb2TNlvM=";
  };
  # help the ort-sys builder
  env = {
    ORT_DYLIB_PATH = "${onnxruntime}/lib/";
  };

  cargoHash = "sha256-5NcmFaRqDla2ei694fJiqNr5n4V3A/ai3/9fzBHNa3s=";

  nativeBuildInputs = [makeWrapper pkg-config];
  buildInputs = [openssl onnx onnxruntime];

  doCheck = false;

  passthru.category = "Utilities";

  meta = with lib; {
    description = " Permanent memory for AI agents. Single binary, zero dependencies, MCP native.";
    homepage = "https://github.com/rtk-ai/icm";
    changelog = "https://github.com/rtk-ai/icm/releases/tag/v${version}";
    license = licenses.mit;
    sourceProvenance = with sourceTypes; [fromSource];
    mainProgram = "icm";
    platforms = platforms.unix;
  };
}
