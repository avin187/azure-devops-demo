#!/usr/bin/env bash
set -euo pipefail
echo "🔑 Azure login (device code)..."
az login --use-device-code
SUB=$(az account show --query id -o tsv)
TEN=$(az account show --query tenantId -o tsv)
echo "✅ Logged in. SUBSCRIPTION=$SUB TENANT=$TEN"
