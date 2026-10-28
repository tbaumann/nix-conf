{ ... }:
{
  programs.ssh = {
    enable = true;
    matchBlocks."*" = {
      addKeysToAgent = "yes";
      forwardAgent = true;
    };
    includes = [ "config.d" ];
  };
}
