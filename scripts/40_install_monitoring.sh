#!/usr/bin/env bash
set -euo pipefail
NS=monitoring
kubectl create namespace $NS --dry-run=client -o yaml | kubectl apply -f -
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm upgrade --install monitoring prometheus-community/kube-prometheus-stack \
  -n $NS -f monitoring/values-kube-prom-stack.yaml
kubectl get pods -n $NS
