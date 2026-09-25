#!/usr/bin/env bash
# Idempotent homelab secrets bootstrap for the nuc k3s cluster.
# Run as root ON THE NUC. Uses the local k3s admin kubeconfig.
# Only creates/seeds values that are missing (keeps existing = no surprise rotation);
# existing secrets are left untouched.
#
# Generates:
#   1. Pi-hole admin password -> Secret pihole-admin (ns dns, key "password")
#      and a copy pihole-auth (ns external-dns, key "password") for external-dns
#      (env secretKeyRef is same-namespace only).
#   2. Hermeum better-auth secret + public URL -> Secret hermeum-secret (ns hermeum).
#   3. Kubernetes Dashboard admin login token -> saved to /persist/var/lib/dashboard-admin-token
#      (minted fresh; tokens expire).
#
# After running, restart the affected workloads so they pick up the values:
#   kubectl -n hermeum rollout restart deployment hermeum
#   kubectl -n external-dns rollout restart deployment external-dns
#   kubectl -n dns rollout restart statefulset pihole
set -euo pipefail

K="kubectl --kubeconfig /etc/rancher/k3s/k3s.yaml"
RAND_HEX() { openssl rand -base64 "$1" | tr -d '\n' ; }

echo "== 1/3 Pi-hole admin password =="
if ! "$K" -n dns get secret pihole-admin &>/dev/null; then
  PASSWORD="$(RAND_HEX 24)"
  "$K" -n dns create secret generic pihole-admin \
    --from-literal=password="$PASSWORD" \
    --dry-run=client -o yaml | "$K" apply -f -
  echo "  pihole-admin created in dns"
else
  PASSWORD="$("$K" -n dns get secret pihole-admin -o jsonpath='{.data.password}' | base64 -d)"
  echo "  pihole-admin exists - reusing existing value"
fi
# Copy into external-dns namespace (same-ns secretKeyRef rule).
"$K" -n external-dns create secret generic pihole-auth \
  --from-literal=password="$PASSWORD" \
  --dry-run=client -o yaml | "$K" apply -f -
echo "  pihole-auth ensured in external-dns"

echo "== 2/3 Hermeum better-auth (Secret hermeum-secret) =="
BETTER_AUTH_URL="https://hermeum.home.tilman.baumann.name"
CUR="$("$K" -n hermeum get secret hermeum-secret -o jsonpath='{.data.better-auth-secret}' 2>/dev/null || true)"
if [ -z "$CUR" ]; then
  BA="$(RAND_HEX 32)"
else
  BA="$(printf '%s' "$CUR" | base64 -d)"
fi
"$K" -n hermeum patch secret hermeum-secret --type=merge \
  -p "{\"stringData\":{\"better-auth-secret\":\"$BA\",\"better-auth-url\":\"$BETTER_AUTH_URL\"}}"
echo "  better-auth-secret + better-auth-url set"

echo "== 3/3 Kubernetes Dashboard admin token =="
TOKEN="$("$K" -n kubernetes-dashboard create token admin-user --duration=720h 2>/dev/null || true)"
if [ -n "$TOKEN" ]; then
  mkdir -p /persist/var/lib
  echo "$TOKEN" > /persist/var/lib/dashboard-admin-token
  echo "  admin token saved to /persist/var/lib/dashboard-admin-token"
else
  echo "  WARN: could not mint token (SA 'admin-user' missing?)"
fi

echo
echo "Done. Restart workloads to apply:"
echo "  $K -n hermeum rollout restart deployment hermeum"
echo "  $K -n external-dns rollout restart deployment external-dns"
echo "  $K -n dns rollout restart statefulset pihole"
