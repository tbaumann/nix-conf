{ lib, ... }:
{
  # Where nixidy syncs the generated manifests for the nuc cluster.
  nixidy.target = {
    repository = "https://github.com/tbaumann/nix-conf";
    branch = "main";
    rootPath = "./manifests/nuc";
  };

  # Base Kubernetes environment: cluster-scoped operators and control planes.
  applications = {
    # Hermeum — control plane for HermesAgent custom resources.
    # Pulls from OCI; bundles its hermes-agent-operator subchart (operator.enabled by default).
    hermeum = {
      namespace = "hermeum";
      createNamespace = true;
      helm.releases.hermeum = {
        chart = lib.helm.downloadHelmChart {
          repo = "oci://ghcr.io/hermeum/charts";
          chart = "hermeum";
          version = "0.1.3";
          chartHash = "sha256-d4mvZopaZB+MfaUL0KBel6FA6wvfiGnX28PGNqB3FcY=";
        };
        values = { };
      };
    };

    # Cloud Native Postgres operator — declarative PostgreSQL via Cluster CRs.
    cloudnative-pg = {
      namespace = "cnpg-system";
      createNamespace = true;
      helm.releases.cloudnative-pg = {
        chart = lib.helm.downloadHelmChart {
          repo = "https://cloudnative-pg.io/charts";
          chart = "cloudnative-pg";
          version = "0.29.0";
          chartHash = "sha256-kEFuvG5CsJ/iloIbBKcrDj1Ta0ZRxJ+KJ5LODMjbY8A=";
        };
        values = { };
      };
    };
  };
}
