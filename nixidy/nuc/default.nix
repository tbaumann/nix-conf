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

    # Kubernetes Dashboard — general-purpose web UI for the cluster.
    # Chart repo moved from kubernetes.github.io to kubernetes-retired.github.io.
    kubernetes-dashboard = {
      namespace = "kubernetes-dashboard";
      createNamespace = true;
      helm.releases.kubernetes-dashboard = {
        chart = lib.helm.downloadHelmChart {
          repo = "https://kubernetes-retired.github.io/dashboard";
          chart = "kubernetes-dashboard";
          version = "7.14.0";
          chartHash = "sha256-n0HvDe1+pS9Zu4JqP9PwWkubAvp9F8KGaB0tPaLShHA=";
        };
        # Expose the kong gateway (the dashboard entrypoint) on a NodePort so
        # the UI is reachable over the LAN at https://<nuc-ip>:32443.
        values = {
          kong.proxy = {
            type = "NodePort";
            tls.nodePort = 32443;
          };
        };
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
