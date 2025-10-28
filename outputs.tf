output "vpc_id" {
  value = module.vpc.vpc_id
}
output "eks_cluster_name" {
  value = try(module.eks.cluster_name, "")
}
output "ecr_repos" {
  value = module.ecr.repositories
}
output "edge_ips" {
  value = try(module.edge_nodes.edge_ips, [])
}
