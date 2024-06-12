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
      path = "/home/tilli/direnvs/backup/garage/.envrc";
      mode = "600";
      owner = "tilli";
    };
    direnv-backup-rsync = {
      file = ../secrets/direnv-backup-rsync-net.age;
      path = "/home/tilli/direnvs/backup/rsync.net/.envrc";
      mode = "600";
      owner = "tilli";
    };
    "openrc-fs.stackxperts.com" = {
      file = ../secrets/openrc-fs.stackxperts.com.age;
      path = "/home/tilli/direnvs/clouds/fs.stackxperts.com/.envrc";
      mode = "600";
      owner = "tilli";
    };
    tailscale-key = {
      file = ../secrets/tailscale-key.age;
    };
    stack_baumann-cbxgate_cbxnet_de_ovpn = {
      file = ../secrets/stack_baumann-cbxgate.cbxnet.de.ovpn.age;
    };
    stack_baumann-cbxgate_cbxnet_de-password = {
      file = ../secrets/stack_baumann-cbxgate_cbxnet_de-password.age;
    };
    nix-access-tokens-github = {
      file = ../secrets/nix-access-tokens-github.age;
      mode = "644";
    };
    gist-cli = {
      file = ../secrets/gist-cli.age;
      path = "/home/tilli/.gist";
      mode = "600";
      owner = "tilli";
    };
  };
}
