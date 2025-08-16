#!/usr/bin/env bash
set -euo pipefail
echo "🧹 Cleaning up Helm releases..."
helm uninstall demo -n demo || true
helm uninstall monitoring -n monitoring || true
helm uninstall ingress-nginx -n ingress-nginx || true
echo "🧨 Terraform destroy..."
terraform -chdir=infra/terraform destroy -auto-approve
