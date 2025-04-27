{
  inputs,
  pkgs,
  ...
}: {
  imports = [
  ];
  home.packages = with pkgs; [
    netflix
  ];
  home = {
/*
    language = {
      base = "ar_MA.utf8";
      address = "ar_MA.utf8";
      collate = "ar_MA.utf8";
      ctype = "ar_MA.utf8";
      measurement = "ar_MA.utf8";
      messages = "ar_MA.utf8";
      monetary = "ar_MA.utf8";
      numeric = "ar_MA.utf8";
      paper = "ar_MA.utf8";
      telephone = "ar_MA.utf8";
      time = "ar_MA.utf8";
    };
*/
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    username = "chaimae";
    homeDirectory = "/home/chaimae";
  };
}
