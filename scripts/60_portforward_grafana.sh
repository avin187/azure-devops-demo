#!/usr/bin/env bash
set -euo pipefail
echo "🌐 Port-forward Grafana http://localhost:3000 (admin/admin)"
kubectl -n monitoring port-forward svc/monitoring-grafana 3000:80
