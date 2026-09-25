{
  inputs,
  self,
  ...
}:
{
  imports = [
    inputs.clan-core.flakeModules.default
  ];
  clan = {
    meta = {
      name = "prawns";
      description = "Tilmans home clan";
      # -> move to k8s domain = "home.tilman.baumann.name";
    };

    specialArgs = {
      inherit inputs;
      inherit self;
    };
    inventory = {
      ## Machines
      machines = {
        zuse = {
          tags = [
            "pc"
            "desktop"
            "kmscon"
          ];
          deploy.targetHost = "tilli@zuse.tail84117.ts.net";
        };
        zuse-klappi = {
          tags = [
            "pc"
            "desktop"
            "laptop"
            "kmscon"
          ];
          deploy.targetHost = "tilli@zuse-klappi.tail84117.ts.net";
        };
        saugbox = {
          tags = [
            "pc"
            "kmscon"
          ];
          deploy.targetHost = "tilli@saugbox.tail84117.ts.net";
        };
        nas = {
          tags = [
            "nixos"
            "nas"
            "arm"
            "ci"
          ];
          #deploy.targetHost = "root@nas.tail84117.ts.net";
          deploy.targetHost = "root@nas.local";
        };
        nuc = {
          tags = [
            "nixos"
            "nas"
            "pc"
            "ci"
          ];
          #deploy.targetHost = "root@nas.tail84117.ts.net";
          deploy.targetHost = "root@nuc.local";
        };
      };
      ## Clan Services
      instances = {
        laptop = {
          module = {
            name = "importer";
            input = "clan-core";
          };
          roles.default.tags.laptop = { };
          roles.default.extraModules = [ ./common/laptop.nix ];
        };
        kmscon = {
          module = {
            name = "importer";
            input = "clan-core";
          };
          roles.default.tags.kmscon = { };
          roles.default.extraModules = [ ./common/services/kmscon.nix ];
        };
        clan-cache = {
          module = {
            name = "trusted-nix-caches";
            input = "clan-core";
          };
          roles.default.machines.all = { };
        };
        admin = {
          module = {
            name = "admin";
            input = "clan-core";
          };
          roles.default.machines.all = {
            settings.allowedkeys = {
              "zuse" =
                "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQD06odwjYayF8YNuuzVydz5/aA8oo7HuPi/S1L7spbxRDU9h+QnSgOlrQkky1g8s+x39MHMLUF/6SZOOQHinBCecTmpGUF/QpPjWSQHafIURjat3L4dScsupVc+IwmbDgLkUxMux/PLkfzxk2YdqpojzcILI5kvGNR2PPEs/vYp2+nqry9TjDfz4OCv4b+FtjqzlZalrSbt9wkTTWK/Sd7AlAQegkOLKB+IrBORIEKknYC+UnyCr5HH+aAD0qgKp3cxh2dIUUEDu3wSyCzv/nus1NqHIaNSfCxwNNrUd53XJOg2wwIV8NQZ0R7md4wYwdWR/I5DM9iH8ckj8kkj/isyKC49vfuOucsQhApQErM4TYVbO5Ckym72TzUUJYzaRVgVAOfOnCsrjW9ihh/RSYWTFnjq6X8QUp6NX3BdUYyoKtxvbKzFdggNPEr4hLpSfOJzHqFJCdH2lyC8Apd1Y56Km+eBz/46kbvaUCvwfgSbQr/lOQzWq63w3S7lnB597/c= tilli@zuse";
              "zuse-klappi" =
                "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDHV2grChMteVSJYEfW4mHagZlcyAtTszKd2AfK++/6l5FLpPMdP+Ly8kLP2YO8jc3ThDBxMxhNO/SuALkcS3A/3NkswE/khyqYJFgR5gIbMNwFPerrDc7jEmSzHFIbsGOv73OEjnjiyDklYWHZYl/S5gKMLIKJEP+ou8OmmqAWmhFtd3kpkzkKgt9TMwLqcUvskyA4qzRtG0Sc9ED70lLMsLD2ymbYMDLkZTb4+KPtqJl+RTHaex6zG+WYKSWJ0J+jof4SaeITiIUaTAICx0LFYctEzwKEJ0skoDkhmi5N+UJloOIjvtdH0jNFgeju5rYFCOzmYoqiPdzAxn3Rp1Ffo9qIYDcoSWI0/K+ETw0YymoKlZS7vk4Q7kj+GiLcqCipjiMd+eKvHGdZe/6zP984DDxZo25vHRZ15VhmpEGQn4TmNcaPZTJBvy6S2RHmcnfbna/0KS2WjdEfR04x941iChDxAOi88YisT0SKBi4F8iE+pRdpydd8gdfYRQbFUnk= tilli@zuse-klappi";
              "github" =
                "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILn54f+ZJEaFUaFb7+H43QJJwtqTOhqEWTmbsxqM6r0W tilli@zuse";
            };
          };
        };
        /*
          sshd = {
            module = {
              name = "sshd";
              input = "clan-core";
            };
            roles.client = {
              tags.all = {};
              settings = {
                certificate.searchDomains = ["tail84117.ts.net" "local"];
              };
            };
            roles.server = {
              tags.all = {};
              settings = {
                hostKeys.rsa.enable = true;
                certificate.searchDomains = ["tail84117.ts.net" "local"];
              };
            };
          };
        */
        user-tilli = {
          module = {
            name = "users";
            input = "clan-core";
          };
          roles.default.machines.all = { };
          roles.default.settings = {
            user = "tilli";
            share = true;
            groups = [
              "adbusers"
              "cdrom"
              "dialout"
              "disk"
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
              "tss"
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
          roles.default.tags.desktop = { };
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
          roles.default.tags.all = { };
          roles.default.settings.networks.home = { };
        };
        monitoring = {
          module = {
            name = "monitoring";
            input = "clan-core";
          };

          roles = {
            client = {
              # Enable monitoring for all machines in the clan.
              tags = [ "all" ];
              # Decide whether or not your server is reachable via https.
              settings.useSSL = true;
            };

            # Select one machine as the central monitoring server.
            # Hint: This is currently limited to exactly one server.
            server.machines.nas.settings = {
              # Optionally enable grafana for dashboards and alerts.
              grafana.enable = true;
            };
          };
        };
        dm-dns = {
          module.name = "dm-dns";
          roles.default.tags = [ "all" ];
          # nuc pushes the zone file into the data-mesher network (needs a
          # push role, otherwise network.files stays empty and data-mesher
          # refuses to start).
          roles.push.machines.nuc = { };
        };
        # data-mesher distributes the dm-dns zone file peer-to-peer. It needs at
        # least one bootstrap peer to form the network; nuc is the always-on
        # server (nas is often off).
        data-mesher = {
          module.name = "data-mesher";
          roles.default.tags = [ "all" ];
          roles.bootstrap.machines.nuc = { };
        };
      };
    };
  };
}
