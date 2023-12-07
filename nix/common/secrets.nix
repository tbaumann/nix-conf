{inputs, ...}: {
  age.secrets = {
    tilli-id_rsa.file = ../secrets/tilli-id_rsa.age;
    cloak-accounts = {
      file = ../secrets/cloak-accounts.age;
      path = "/home/tilli/.cloak/accounts";
      owner = "tilli";
    };
    restic-password = {
      file = ../secrets/restic-password.age;
      path = "/nixos/secrets/restic-password";
      mode = "600";
    };
    restic-garage-credentials = {
      file = ../secrets/restic-garage-credentials.age;
      path = "/nixos/secrets/garage_gredentials";
      mode = "600";
    };
    direnv-backup-garage = {
      file = ../secrets/direnv-backup-garage.age;
      path = "/home/tilli/direnvs/backup-=/garage/.envrc";
      mode = "600";
      owner = "tilli";
    };
    direnv-backup-rsync = {
      file = ../secrets/direnv-backup-rsync-net.age;
      path = "/home/tilli/direnvs/backup-=/rsync.net/.envrc";
      mode = "600";
      owner = "tilli";
    };
    tailscale-key = {
      file = ../secrets/tailscale-key.age;
    };
  };

}
