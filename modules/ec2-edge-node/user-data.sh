#!/bin/bash
# User-data template for edge nodes.
set -euo pipefail

# Start Docker
systemctl enable docker || true
systemctl start docker || true

# Configure k3s agent if variables are available
if [ -n "$${K3S_URL:-}" ] && [ -n "$${K3S_TOKEN:-}" ]; then
  curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="agent" \
    K3S_URL="https://$${K3S_URL}:6443" \
    K3S_TOKEN="$${K3S_TOKEN}" sh -
fi
