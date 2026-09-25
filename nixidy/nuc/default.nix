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
        values = {
          # Web UI ingress through the Traefik ingress (selfsigned for now).
          ingress = {
            enabled = true;
            className = "traefik";
            host = "hermeum.home.tilman.baumann.name";
            annotations."traefik.ingress.kubernetes.io/router.tls.certresolver" = "selfsigned";
            tls.enabled = true;
          };
        };
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
    # Pi-hole — LAN ad-blocking DNS server. Serves the `home.tilman.baumann.name`
    # zone for the whole cluster: external-dns auto-creates a local A record for
    # every ingress host under that domain (replacing the old wildcard).
    # DNS is exposed as a LoadBalancer Service so it is reachable on the nuc's
    # node IP (192.168.2.85) on port 53. Machines route `~home.tilman.baumann.name`
    # queries here (see common/core.nix).
    pihole = {
      namespace = "dns";
      createNamespace = true;
      helm.releases.pihole = {
        chart = lib.helm.downloadHelmChart {
          repo = "https://mojo2600.github.io/pihole-kubernetes";
          chart = "pihole";
          version = "2.38.0";
          chartHash = "sha256-IxNqJfgw0lH9c9h5VcdvTCoIDHoWGdDOMYwEgTEHLc8=";
        };
        values = {
          # Password comes from the `pihole-admin` Secret (ns dns), created by
          # scripts/secrets-setup.sh. Same-ns secretKeyRef means external-dns
          # needs its own copy (pihole-auth, ns external-dns).
          admin = {
            enabled = true;
            existingSecret = "pihole-admin";
            passwordKey = "password";
          };
          # LoadBalancer so DNS is reachable on the nuc node IP (192.168.2.85):53.
          serviceDns.type = "LoadBalancer";
        };
      };
    };
    # external-dns — auto-creates Pi-hole local DNS records for ingress hosts.
    # Tracks both standard networking.k8s.io/Ingresses (e.g. hermeum) and Traefik
    # IngressRoutes (e.g. kubernetes-dashboard) under home.tilman.baumann.name.
    # Provider configured via its env vars (no PIHOLE_TOKEN exists; the chart's
    # appVersion 0.22.0 reads EXTERNAL_DNS_PIHOLE_*).
    external-dns = {
      namespace = "external-dns";
      createNamespace = true;
      helm.releases.external-dns = {
        chart = lib.helm.downloadHelmChart {
          repo = "https://kubernetes-sigs.github.io/external-dns";
          chart = "external-dns";
          version = "1.22.0";
          chartHash = "sha256-JUrCYnJgt0vHlSaag+vqdMw2wZQFSDPqVYG1owxiMX8=";
        };
        values = {
          provider.name = "pihole";
          sources = [
            "ingress"
            "traefik-proxy"
          ];
          # Only manage hosts under the home zone; the whitelabel chart RBAC is
          # enough for the traefik-proxy source (it grants CRD perms when present).
          domainFilters = [ "home.tilman.baumann.name" ];
          policy = "sync";
          # Pi-hole only stores A/AAAA/CNAME records — no TXT ownership registry.
          registry = "noop";
          # Pihole provider env (verified against external-dns docs/tutorial).
          # Password is pulled from the `pihole-auth` Secret (ns external-dns) so
          # no literal secret lands in nixidy; see scripts/secrets-setup.sh.
          env = [
            {
              name = "EXTERNAL_DNS_PIHOLE_SERVER";
              value = "http://pihole-web.dns.svc:80";
            }
            {
              name = "EXTERNAL_DNS_PIHOLE_PASSWORD";
              valueFrom.secretKeyRef = {
                name = "pihole-auth";
                key = "password";
              };
            }
          ];
        };
      };
    };
  };
}
