{ pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    commandLineArgs = [
      "--enable-features=VaapiVideoDecodeLinuxGL"
      "--ozone-platform=wayland"
    ];
    extensions = [
      { id = "nngceckbapebfimnlniiiahkandclblb"; }
      { id = "iohcojnlgnfbmjfjfkbhahhmppcggdog"; }
      { id = "dhdgffkkebhmkfjojejmpbldmpobfkfo"; }
      { id = "gmbicfpadlmgkfhfepknbmemfhahelll"; }
      { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; }
    ];
    dictionaries = [
      pkgs.hunspellDictsChromium.en_GB
      pkgs.hunspellDictsChromium.de_DE
    ];
  };
}
