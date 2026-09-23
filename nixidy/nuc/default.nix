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
    # Ingress controller. k3s's bundled Traefik is disabled so the whole config
    # (entrypoints, cert resolver, routing) lives here declaratively. Uses the
    # built-in `selfsigned` resolver for now; swap for a Let's Encrypt
    # DNS-01 resolver when the domain is properly exposed.
    traefik = {
      namespace = "traefik";
      createNamespace = true;
      helm.releases.traefik = {
        chart = lib.helm.downloadHelmChart {
          repo = "https://helm.traefik.io/traefik";
          chart = "traefik";
          version = "41.6.0";
          chartHash = "sha256-J3ndRl7lClGbEKILQaNGKcta2uhK1H6aLlvr07kheek=";
        };
        values = {
          certificatesResolvers.selfsigned.selfsigned = { };
          service.spec.type = "LoadBalancer";
        };
      };
      # Per-service routes (Traefik CRD). Raw YAML until nixidy is bumped to a
      # revision exposing generators.fromCRDModule for typed Traefik resources.
      extraRawYamls = [ ./ingressroute-dashboard.yaml ];
    };
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
        # Reachable only through the Traefik ingress (nixidy), which terminates
        # TLS and forwards HTTP to the kong gateway on :80. See the
        # dashboard IngressRoute in the traefik application.
        values = {
          kong.proxy = {
            type = "ClusterIP";
            http.enabled = true;
          };
        };
      };

      # Admin login account for the dashboard. No secret lives in the repo:
      # the bearer token is minted on demand at login time with
      # `kubectl -n kubernetes-dashboard create token admin-user`.
      resources = {
        serviceAccounts.admin-user = {
          metadata.namespace = "kubernetes-dashboard";
        };
        clusterRoleBindings.admin-user = {
          metadata.name = "admin-user";
          roleRef = {
            apiGroup = "rbac.authorization.k8s.io";
            kind = "ClusterRole";
            name = "cluster-admin";
          };
          subjects = [
            {
              kind = "ServiceAccount";
              name = "admin-user";
              namespace = "kubernetes-dashboard";
            }
          ];
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
