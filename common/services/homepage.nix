{ config, ... }:
{
  services.homepage-dashboard = {
    enable = true;
    settings = {
      statusStyle = "dot";
      color = "gray";
      layout = {
        Media = {
          icon = "mdi-multimedia";
          style = "row";
          columns = 3;
        };
      };
      quicklaunch = {
        searchDescriptions = true;
        hideInternetSearch = true;
        showSearchSuggestions = true;
        hideVisitURL = true;
      };
    };

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
    services = [
      {
        Media = [
          {
            Jellyfin = {
              description = "Media Library";
              href = "http://nas.local:8096/";
              siteMonitor = "http://nas.local:8096/";
              icon = "sh-jellyfin";
              widget = {
                type = "jellyfin";
                url = "http://nas.local:8096";
                key = "df669e9b3c4544e99e87d6915a6d1b03";
                enableUser = true; # optional, defaults to false
              };
            };
          }
          {
            Transmission = {
              description = "Torrent Fetcher";
              href = "http://nas.local:9091/";
              siteMonitor = "http://nas.local:9091/";
              icon = "sh-transmission";
              widget = {
                type = "transmission";
                url = "http://nas.local:8096";
                # username = "";
                password = "{5b762abb352aadcc07d18e8c1ac29a9d25ac3296Ojv0wQFF";
                hideErrors = true;
              };
            };
          }
          {
            Prowlarr = {
              description = "Indexer Manager";
              href = "http://nas.local:9696/";
              siteMonitor = "http://nas.local:9696/";
              icon = "sh-prowlarr";
              widget = {
                type = "prowlarr";
                url = "http://nas.local:9696";
                key = "40bdd6964f80480f88de1984003bf81c";
              };
            };
          }
          {
            Radarr = {
              description = "Movies Fetcher";
              href = "http://nas.local:7878/";
              siteMonitor = "http://nas.local:7878/";
              icon = "sh-radarr";
              widget = {
                type = "radarr";
                url = "http://nas.local:7878";
                key = "deb76d2baaa44522b738da88fe9ecb6b";
              };
            };
          }
          {
            Sonarr = {
              description = "Series Fetcher";
              href = "http://nas.local:8989/";
              siteMonitor = "http://nas.local:8989/";
              icon = "sh-sonarr";
              widget = {
                type = "sonarr";
                url = "http://nas.local:8989";
                key = "300600408e83467b9f860d46eaa877d4";
              };
            };
          }
          {
            Bazarr = {
              description = "Subvtitles Fetcher";
              href = "http://nas.local:6767/";
              siteMonitor = "http://nas.local:6767/";
              icon = "sh-bazarr";
              widget = {
                type = "bazarr";
                url = "http://nas.local:6767";
                key = "e8baca306164a08d3703ded964469c86";
              };
            };
          }
          {
            Jellyseer = {
              description = "Request Manager";
              href = "http://nas.local:5055/";
              siteMonitor = "http://nas.local:5055/";
              icon = "sh-jellyseerr";
              widget = {
                type = "jellyseerr";
                url = "http://nas.local:5055";
                key = "MTczNjQyOTEyNzg2MWQzMTEyZTMyLTJkMTAtNDJiYy1iYzE5LTEyN2VmNzc1MmYyMQ==";
              };
            };
          }
        ];
      }
      {
        Monitoring = [
          {
            Grafana = {
              description = "Grafana";
              href = "http://nas.local:3000";
              siteMonitor = "http://nas.local:3000";
              icon = "sh-grafana";
              widget = {
                type = "grafana";
                url = "http://nas.local:3000";
                username = "admin";
                password = "admin";
              };
            };
          }
        ];
      }
    ];
    widgets = [
      {
        resources = {
          label = "System";
          disk = "/";
          cpu = true;
          memory = true;
        };
      }
      {
        resources = {
          label = "Media";
          disk = "/media";
        };
      }
    ];
  };
}
