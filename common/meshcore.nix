{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.meshcoretomqtt.nixosModules.default];
  services.mctomqtt = {
    enable = true;
    iata = "KSF";
    serialPorts = ["/dev/ttyUSB0"];
  };
}
