module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.0.0"

  cluster_name    = "${var.project}-eks"
  cluster_version = "1.28"
  subnets         = var.subnets
  vpc_id          = var.vpc_id

  node_groups = {
    core_nodes = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_types   = [var.eks_node_instance_type]
      key_name         = var.key_name
    }
  }

  tags = {
    project = var.project
  }
}

output "cluster_name" {
  value = module.eks.cluster_id
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}
