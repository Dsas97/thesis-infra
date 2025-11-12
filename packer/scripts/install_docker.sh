#!/bin/bash
set -e

# Si no somos root, reinicia el script como root
if [ "$EUID" -ne 0 ]; then
  exec sudo bash "$0" "$@"
fi

echo "Esperando a que apt esté libre..."
while sudo fuser /var/lib/dpkg/lock >/dev/null 2>&1 || \
      sudo fuser /var/lib/apt/lists/lock >/dev/null 2>&1 || \
      sudo fuser /var/cache/apt/archives/lock >/dev/null 2>&1; do
  echo "Apt todavía está ocupado, esperando 5 segundos..."
  sleep 5
done

echo "✅ Apt está disponible, continuando con la instalación..."

apt-get update -y
apt-get install -y ca-certificates curl gnupg lsb-release

mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list

apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io -y
systemctl enable docker
