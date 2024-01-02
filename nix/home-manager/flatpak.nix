{
  ...
}: {
  services.flatpak = {
    remotes = [{
      name = "flathub"; location = "https://flathub.org/repo/flathub.flatpakrepo";
    }];
    packages = [
#      { appId = "re.sonny.Tangram"; origin = "flathub";  }
  #    "re.sonny.Tangram"
    ];
  };
}
