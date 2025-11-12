output "k3s_master_ip" {
  description = "Dirección IP pública del servidor K3s master"
  value       = aws_instance.k3s_master.public_ip
}

output "k3s_url" {
  description = "URL de conexión del servidor K3s"
  value       = "https://${aws_instance.k3s_master.public_ip}:6443"
}

output "k3s_token" {
  description = "Token de autenticación del servidor K3s"
  # Este token se obtiene directamente de la instancia una vez levantada
  value = nonsensitive("cat /var/lib/rancher/k3s/server/node-token")
}
