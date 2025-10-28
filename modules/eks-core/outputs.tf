output "cluster_name" { value = try(module.eks.cluster_id, "") }
output "cluster_endpoint" { value = try(module.eks.cluster_endpoint, "") }
