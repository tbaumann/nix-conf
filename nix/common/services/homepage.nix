{...}: {
  services.homepage-dashboard = {
    enable = true;
    bookmarks = [
      {
        System = [
          {
            Github = [
              {
                abbr = "GH";
                href = "https://github.com/tbaumann/nix-conf/";
              }
            ];
          }
        ];
      }
    ];
  };
}
