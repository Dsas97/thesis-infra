# ===============================
# Outputs principales
# ===============================

# Nombre del cluster EKS
output "cluster_name" {
  value = module.eks.cluster_name
}

# Endpoint del cluster EKS
output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

# Archivo kubeconfig para conectar desde CI/CD (nueva versión)
output "cluster_certificate_authority_data" {
  description = "Certificado del cluster EKS (CA data)"
  value       = module.eks.cluster_certificate_authority_data
}

# Archivo kubeconfig para conectar desde CI/CD
#output "kubeconfig" {
#  description = "Archivo kubeconfig generado por EKS"
#  value       = module.eks.kubeconfig
#}

output "k3s_server_url" {
  value = var.k3s_server_url
}

output "k3s_token" {
  value = var.k3s_token
}


# Salida del null_resource que actualiza kubeconfig (opcional, pero útil para depends_on)
#output "update_kubeconfig" {
  #description = "Recurso que actualiza kubeconfig local"
  #value       = null_resource.update_kubeconfig.id
#}

output "null_resource_update_kubeconfig" {
  value = null_resource.update_kubeconfig
}

