{
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    githubActions = {
      enable = true;

      workflows = {
        check = {
          name = "Check Nix configuration";

          on = {
            push.branches = ["main"];
            pullRequest.branches = ["main"];
            workflowDispatch = {};
          };

          defaults.job = {
            runsOn = "ubuntu-latest";
          };

          jobs = {
            check = {
              permissions = {
                id-token = "write";
                contents = "read";
              };
              steps = [
                {
                  name = "Checkout repository";
                  uses = "actions/checkout@v4";
                }
                {
                  name = "Install SSH key";
                  uses = "shimataro/ssh-key-action@v2";
                  with_ = {
                    key = "\${{ secrets.DEPLOY_SSH_KEY }}";
                    known_hosts = "\${{ secrets.SSH_KNOWN_HOSTS }}";
                  };
                }
                /*
                {
                  name = "Setup keys";
                  run = ''
                    install -m 600 -D /dev/null ~/.ssh/id_rsa
                    echo "''${{ secrets.SSH_PRIVATE_KEY }}" > ~/.ssh/id_rsa
                    echo "''${{ secrets.SSH_KNOWN_HOSTS }}" > ~/.ssh/known_hosts
                  '';
                }
                */
                {
                  name = "Setup Tailscale";
                  uses = "tailscale/github-action@v4";
                  with_ = {
                    authkey = "\${{ secrets.TAILSCALE_AUTHKEY }}";
                    tags = "tag:ci";
                    ping = "nas.tail84117.ts.net";
                  };
                }
                {
                  name = "Setup Nix";
                  uses = "DeterminateSystems/determinate-nix-action@v3";
                }
                {
                  name = "Deploy Clan";
                  run = "nix run git+https://git.clan.lol/clan/clan-core -- machines update --tags ci";
                  #run = "nixos-rebuild switch --flake '.#nas' --impure --sudo --target-host root@nas.tail84117.ts.net";
                }
              ];
            };
          };
        };
      };
    };

    # Create a package that copies the workflows to .github/workflows
    packages.workflows = pkgs.runCommand "copy-workflows" {} ''
      mkdir -p $out/.github/workflows
      cp -r ${config.githubActions.workflowsDir}/* $out/.github/workflows/
    '';
  };
}
