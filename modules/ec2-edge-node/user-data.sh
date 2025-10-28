#!/bin/bash
# User-data template for edge nodes.
# Expect environment variables or replacement for K3S URL/TOKEN if used.
set -euo pipefail
# Example: start docker and a simple agent setup
systemctl enable docker || true
systemctl start docker || true
# Placeholder: configure k3s agent if K3S_URL and K3S_TOKEN are available
if [ -n "${K3S_URL:-}" ] && [ -n "${K3S_TOKEN:-}" ]; then
  curl -sfL https://get.k3s.io | K3S_URL=${K3S_URL} K3S_TOKEN=${K3S_TOKEN} INSTALL_K3S_EXEC="agent" sh -
fi
