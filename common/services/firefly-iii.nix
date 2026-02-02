{ ... }:
{
  services.nginx.enable = true;
  services.nginx.defaultHTTPListenPort = 8080;
  services.firefly-iii-data-importer = {
    enable = true;
    enableNginx = true;
    virtualHost = "firefly-iii-data-importer";
  };
  services.firefly-iii = {
    enable = true;
    enableNginx = true;
    # FIXME clan var settings.APP_KEY_FILE
  };
}
