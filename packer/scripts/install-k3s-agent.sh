#!/bin/bash
set -euxo pipefail

# Instala k3s binario sin crear servicios
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="agent --disable-agent --no-deploy=traefik" INSTALL_K3S_BIN_DIR=/usr/local/bin sh -
