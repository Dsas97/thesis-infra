#!/bin/bash
set -e
# Instala k3s agent; requiere K3S_URL/K3S_TOKEN en runtime o user-data
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="agent" sh -
