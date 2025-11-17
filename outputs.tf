output "vpc_id" {
  value = module.vpc.vpc_id
}
output "ecr_repos" {
  value = module.ecr.repositories
}
output "edge_ips" {
  value = try(module.edge_nodes.edge_ips, [])
}

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