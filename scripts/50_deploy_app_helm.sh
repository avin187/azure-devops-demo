#!/usr/bin/env bash
set -euo pipefail
NS=demo
RELEASE=demo
TAG=${1:-local}
ACR_LOGIN_SERVER=$(terraform -chdir=infra/terraform output -raw acr_login_server || echo "REPLACE_ME.azurecr.io")
kubectl create namespace $NS --dry-run=client -o yaml | kubectl apply -f -
helm upgrade --install $RELEASE k8s/helm/app-chart -n $NS \
  --set image.repository="$ACR_LOGIN_SERVER/devops-demo-app" \
  --set image.tag="$TAG" \
  --set monitoring.annotationsScrape=true
kubectl rollout status deploy/$RELEASE -n $NS
kubectl get svc -n $NS
