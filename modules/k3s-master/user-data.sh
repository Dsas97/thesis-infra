#!/bin/bash
# =====================================
# Script de instalación del K3s Master
# =====================================

set -euxo pipefail

echo "[INFO] Instalando dependencias..."
apt-get update -y
apt-get install -y curl

echo "[INFO] Instalando K3s (modo servidor)..."
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--write-kubeconfig-mode 644" sh -

echo "[INFO] K3s instalado correctamente."
echo "[INFO] Kubeconfig disponible en /etc/rancher/k3s/k3s.yaml"

echo "[INFO] Verificando que K3s esté corriendo..."
systemctl is-active --quiet k3s || systemctl restart k3s

