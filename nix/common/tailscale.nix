{inputs, config, ...}:{

  services = {
    tailscale = {
      enable = true;
      authKeyFile= config.age.secrets.tailscale-key.path;
    };
  };
}
