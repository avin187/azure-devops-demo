#!/usr/bin/env bash
set -euo pipefail
ACR_NAME=$(terraform -chdir=infra/terraform output -raw acr_name)
ACR_LOGIN_SERVER=$(terraform -chdir=infra/terraform output -raw acr_login_server)
TAG=${1:-local}
IMAGE="$ACR_LOGIN_SERVER/devops-demo-app:$TAG"
echo "🔧 Logging into ACR $ACR_NAME ..."
az acr login --name "$ACR_NAME"
echo "🐳 Building $IMAGE ..."
docker build -t "$IMAGE" .
echo "⬆️ Pushing $IMAGE ..."
docker push "$IMAGE"
echo "✅ Done: $IMAGE"
