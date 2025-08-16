#!/usr/bin/env bash
set -euo pipefail
cd infra/terraform
terraform init
terraform plan -out tfplan
terraform apply tfplan
terraform output
