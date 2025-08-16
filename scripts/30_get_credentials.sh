#!/usr/bin/env bash
set -euo pipefail
RG=$(terraform -chdir=infra/terraform output -raw resource_group)
AKS=$(terraform -chdir=infra/terraform output -raw aks_name)
echo "⛵ Getting kubeconfig for $AKS in $RG..."
az aks get-credentials --resource-group "$RG" --name "$AKS" --overwrite-existing
kubectl get nodes -o wide
