{pkgs, ...}: {
  virtualisation.podman = {
    enable = true;
    defaultNetwork.settings.dns_enabled = true;
    dockerCompat = true;
    autoPrune.enable = true;
    dockerSocket.enable = true;
  };

  environment.systemPackages = with pkgs; [
    podman-compose
  ];
}
