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
              steps = [
                {
                  name = "Checkout repository";
                  uses = "actions/checkout@v4";
                }
                {
                  name = "Setup Tailscale";
                  uses = "tailscale/github-action@v4";
                  with_ = {
                    oauth-client-id = "{{ secrets.TS_OAUTH_CLIENT_ID }}";
                    oauth-secret = "{{ secrets.TS_OAUTH_SECRET }}";
                    tags = "ci";
                  };
                }
                {
                  name = "Setup Nix";
                  uses = "nixbuild/nix-quick-install-action@v18";
                }
                {
                  name = "Check Nix flake";
                  run = "nix flake check";
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
