{
  inputs,
  config,
  pkgs,
  environment,
  ...
}: {
  imports = [
  ];
  networking.networkmanager.enable = true;
  environment.etc."NetworkManager/system-connections/BAUMANN.nmconnection" = {
    mode = "0400";
    text = ''
      [connection]
      id=BAUMANN
      uuid=68d54e60-f4e0-48cc-8efa-bec09cc269df
      type=wifi
      autoconnect=false
      autoconnect-priority=1
      metered=2
      permissions=
      timestamp=1645708799

      [wifi]
      mac-address-blacklist=
      mode=infrastructure
      ssid=BAUMANN

      [wifi-security]
      key-mgmt=wpa-psk
      psk=ykuBq6rj

      [ipv4]
      dns-search=
      method=auto

      [ipv6]
      addr-gen-mode=stable-privacy
      dns-search=
      ip6-privacy=1
      method=auto

      [proxy]
    '';
  };
  environment.etc."NetworkManager/system-connections/Tilman.nmconnection" = {
    mode = "0400";
    text = ''
      [connection]
      id=Tilman tether
      uuid=00072c16-d877-4950-917c-022f21b0b1ce
      type=wifi
      metered=1
      timestamp=1666176295

      [wifi]
      mode=infrastructure
      ssid=Tilman

      [wifi-security]
      key-mgmt=wpa-psk
      psk=Fanculo19

      [ipv4]
      dns=8.8.8.8;
      method=auto

      [ipv6]
      addr-gen-mode=stable-privacy
      method=auto

      [proxy]
    '';
  };
}
