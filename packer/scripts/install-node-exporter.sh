#!/bin/bash
set -e
useradd --no-create-home --shell /bin/false node_exporter || true
curl -sSL https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz -o /tmp/ne.tar.gz
tar -xzf /tmp/ne.tar.gz -C /tmp
mv /tmp/node_exporter-*/node_exporter /usr/local/bin/
cat >/etc/systemd/system/node_exporter.service <<'EOF'
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=default.target
EOF
systemctl daemon-reload
systemctl enable --now node_exporter
