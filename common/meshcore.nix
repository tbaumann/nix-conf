{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.meshcoretomqtt.nixosModules.default];
  services.mctomqtt = {
    enable = true;
    iata = "EDFQ";
    serialPorts = ["/dev/ttyUSB0"];

    brokers = [
      {
        enabled = true;
        server = "mqtt-us-v1.letsmesh.net";
        port = 334;
        transport = "websockets";
        use-tls = true;
        token-audience = "mqtt-us-v1.letsmesh.net";
        use-auth-token = true;
      }
    ];

    settings = {
      log-level = "DEBUG";
    };
  };
}
