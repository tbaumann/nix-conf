{
  inputs,
  self,
  ...
}: {
  imports = [
    inputs.clan-core.flakeModules.default
  ];
  clan = {
    meta = {
      name = "prawns";
      description = "Tilmans home clan";
    };

    specialArgs = {
      inherit inputs;
      inherit self;
    };
    inventory = {
      ## Machines
      machines = {
        zuse = {
          tags = ["pc" "desktop" "kmscon"];
          deploy.targetHost = "tilli@zuse.tail84117.ts.net";
        };
        zuse-klappi = {
          tags = ["pc" "desktop" "laptop" "kmscon" "meshcore"];
          deploy.targetHost = "tilli@zuse-klappi.tail84117.ts.net";
        };
        sina-open = {
          tags = ["pc" "desktop"];
          deploy.targetHost = "tilli@sina-open.tail84117.ts.net";
        };
      };
      ## Clan Services
      instances = {
        laptop = {
          module = {
            name = "importer";
            input = "clan-core";
          };
          roles.default.tags.laptop = {};
          roles.default.extraModules = ["common/laptop.nix"];
        };
        kmscon = {
          module = {
            name = "importer";
            input = "clan-core";
          };
          roles.default.tags.kmscon = {};
          roles.default.extraModules = ["common/services/kmscon.nix"];
        };
        meshcore = {
          module = {
            name = "importer";
            input = "clan-core";
          };
          roles.default.tags.meshcore = {};
          roles.default.extraModules = ["common/meshcore.nix"];
        };
        clan-cache = {
          module = {
            name = "trusted-nix-caches";
            input = "clan-core";
          };
          roles.default.machines.all = {};
        };
        admin = {
          module = {
            name = "admin";
            input = "clan-core";
          };
          roles.default.machines.all = {
            settings.allowedkeys = {
              "zuse" = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQD06odwjYayF8YNuuzVydz5/aA8oo7HuPi/S1L7spbxRDU9h+QnSgOlrQkky1g8s+x39MHMLUF/6SZOOQHinBCecTmpGUF/QpPjWSQHafIURjat3L4dScsupVc+IwmbDgLkUxMux/PLkfzxk2YdqpojzcILI5kvGNR2PPEs/vYp2+nqry9TjDfz4OCv4b+FtjqzlZalrSbt9wkTTWK/Sd7AlAQegkOLKB+IrBORIEKknYC+UnyCr5HH+aAD0qgKp3cxh2dIUUEDu3wSyCzv/nus1NqHIaNSfCxwNNrUd53XJOg2wwIV8NQZ0R7md4wYwdWR/I5DM9iH8ckj8kkj/isyKC49vfuOucsQhApQErM4TYVbO5Ckym72TzUUJYzaRVgVAOfOnCsrjW9ihh/RSYWTFnjq6X8QUp6NX3BdUYyoKtxvbKzFdggNPEr4hLpSfOJzHqFJCdH2lyC8Apd1Y56Km+eBz/46kbvaUCvwfgSbQr/lOQzWq63w3S7lnB597/c= tilli@zuse";
              "zuse-klappi" = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDHV2grChMteVSJYEfW4mHagZlcyAtTszKd2AfK++/6l5FLpPMdP+Ly8kLP2YO8jc3ThDBxMxhNO/SuALkcS3A/3NkswE/khyqYJFgR5gIbMNwFPerrDc7jEmSzHFIbsGOv73OEjnjiyDklYWHZYl/S5gKMLIKJEP+ou8OmmqAWmhFtd3kpkzkKgt9TMwLqcUvskyA4qzRtG0Sc9ED70lLMsLD2ymbYMDLkZTb4+KPtqJl+RTHaex6zG+WYKSWJ0J+jof4SaeITiIUaTAICx0LFYctEzwKEJ0skoDkhmi5N+UJloOIjvtdH0jNFgeju5rYFCOzmYoqiPdzAxn3Rp1Ffo9qIYDcoSWI0/K+ETw0YymoKlZS7vk4Q7kj+GiLcqCipjiMd+eKvHGdZe/6zP984DDxZo25vHRZ15VhmpEGQn4TmNcaPZTJBvy6S2RHmcnfbna/0KS2WjdEfR04x941iChDxAOi88YisT0SKBi4F8iE+pRdpydd8gdfYRQbFUnk= tilli@zuse-klappi";
            };
          };
        };
        sshd = {
          module = {
            name = "sshd";
            input = "clan-core";
          };
          roles.server.tags.all = {};
          roles.client.tags.all = {};
          roles.server.settings = {
            hostKeys.rsa.enable = true;
          };
        };
        user-tilli = {
          module = {
            name = "users";
            input = "clan-core";
          };
          roles.default.tags.all = {};
          roles.default.settings = {
            user = "tilli";
            share = true;
            groups = [
              "adbusers"
              "cdrom"
              "disk"
              "dialout"
              "docker"
              "input"
              "kvm"
              "libusb"
              "libvirtd"
              "lp"
              "networkmanager"
              "plugdev"
              "podman"
              "scanner"
              "users"
              "wheel"
              "wireshark"
            ];
          };
        };
        user-chaimae = {
          module = {
            name = "users";
            input = "clan-core";
          };
          roles.default.tags.desktop = {};
          roles.default.settings = {
            user = "chaimae";
            share = true;
            groups = [
              "cdrom"
              "input"
              "lp"
              "networkmanager"
              "plugdev"
              "scanner"
              "users"
            ];
          };
        };
        home-wifi = {
          module = {
            name = "wifi";
            input = "clan-core";
          };
          roles.default.tags.all = {};
          roles.default.settings.networks.home = {};
        };
        syncthing = {
          module = {
            name = "syncthing";
            input = "clan-core";
          };
          roles.peer = {
            tags.all = {};
            settings.folders = {
              Wallpapers = {
                path = "~/wallpapers";
              };
              Documents = {
                path = "~/Documents";
              };
              Music = {
                path = "~/Music";
              };
              Phoniebox = {
                path = "~/phoniebox";
              };
            };
            extraModules = [./common/syncthing.nix];
          };
        };
      };
    };
  };
}
